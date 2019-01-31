class ChallengesController < ApplicationController
  before_action :find_challenge, only: [:show, :edit, :update, :destroy, :leave, :add_time]

  # after_action :set_guest, only: [:set_guest]
  def index
    if current_user.present?
      if params[:tag].present?
        @challenges = Challenge.where.not(host_id: current_user.id)
        @challenges = @challenges.where("host_gamertag ILIKE ?", "%#{params[:tag]}%")
        @challenges = @challenges.where("stake >= ?", "#{params[:min]}") if params[:min].present?
        @challenges = @challenges.where("stake <= ?", "#{params[:max]}") if params[:max].present?
        @challenges = @challenges.where("game = ?", "#{params[:game]}") if params[:game].present?
      elsif params[:min].present?
        @challenges = Challenge.where.not(host_id: current_user.id)
        @challenges = @challenges.where("stake >= ?", "#{params[:min]}")
        @challenges = @challenges.where("stake <= ?", "#{params[:max]}") if params[:max].present?
        @challenges = @challenges.where("game = ?", "#{params[:game]}") if params[:game].present?
        @challenges = @challenges.where("host_gamertag ILIKE ?", "%#{params[:tag]}%") if params[:tag].present?
      elsif params[:max].present?
        @challenges = Challenge.where.not(host_id: current_user.id)
        @challenges = @challenges.where("stake <= ?", "#{params[:max]}")
        @challenges = @challenges.where("stake >= ?", "#{params[:min]}") if params[:min].present?
        @challenges = @challenges.where("game = ?", "#{params[:game]}") if params[:game].present?
        @challenges = @challenges.where("host_gamertag ILIKE ?", "%#{params[:tag]}%") if params[:tag].present?
      elsif params[:game].present?
        @challenges = Challenge.where.not(host_id: current_user.id)
        @challenges = @challenges.where("game = ?", "#{params[:game]}")
        @challenges = @challenges.where("stake >= ?", "#{params[:min]}") if params[:min].present?
        @challenges = @challenges.where("stake <= ?", "#{params[:max]}") if params[:max].present?
        @challenges = @challenges.where("host_gamertag ILIKE ?", "%#{params[:tag]}%") if params[:tag].present?
      else
        @challenges = Challenge.where.not(host_id: current_user.id)

      end
    else
      @challenges = Challenge.all
      @challenges = @challenges.where("game = ?", "#{params[:game]}") if params[:game].present?
      @challenges = @challenges.where("stake >= ?", "#{params[:min]}") if params[:min].present?
      @challenges = @challenges.where("stake <= ?", "#{params[:max]}") if params[:max].present?
      @challenges = @challenges.where("host_gamertag ILIKE ?", "%#{params[:tag]}%") if params[:tag].present?

    end
  end

  def show
  end

  def new
    @challenge = Challenge.new
  end

  def create
    @challenge = Challenge.new(strong_params)
    if @challenge.game == "CS:GO"
      @challenge.photo = "http://res.cloudinary.com/dcqopgfjo/image/upload/c_thumb,g_center,h_300,w_200/v1542910479/csgo.0.webp"
    elsif @challenge.game == "Fifa"
      @challenge.photo = "http://res.cloudinary.com/dcqopgfjo/image/upload/c_thumb,g_center,h_300,w_200/v1542972540/embed-only-fifa-19-champions-edition-cover_1i6898nbr13qi1e6datio2ajq4.jpg"
    elsif @challenge.game == "COD"
      @challenge.photo = "http://res.cloudinary.com/dcqopgfjo/image/upload/c_thumb,e_art:incognito,g_center,h_300,q_100,w_200/v1542973488/call-of-duty-modern-warfare-remastered_68bp.jpg"
    end
    @challenge.host = current_user
    current_user.balance_cents -= @challenge.stake*100
    if @challenge.save
      current_user.save
      # @challenge.create_activity key: 'challenge.commented_on', owner: current_user
      redirect_to challenge_path(@challenge)
    else
      render :new
    end
  end

  def edit
    if @challenge.status != "accepted" || @challenge.status != "played"
      redirect_to challenge_path(@challenge)
    end
  end

  def update
    if @challenge.update(strong_params)
      redirect_to challenge_path(@challenge)
    else
      render :edit
    end
  end

  def destroy
    # if there is a guest sends automated message
    if @challenge.guest_id
      @chatroom = Chatroom.new
      @chatroom = @chatroom.find_chatroom_for_destroy(@chatroom, current_user, @challenge.host)
      @message = Message.new
      @message = host_left_message(@message, current_user, @chatroom, @challenge)
      @challenge.destroy
    else
      @challenge.destroy
    end
    flash[:info] = "Challenge Deleted ... Chicken!"
    redirect_to challenges_path
  end

  def set_guest
    @challenge = Challenge.find(params[:challenge_id])
    @challenge.guest = current_user
    @challenge.time_remaining = (DateTime.now + 48.hours)
    current_user.balance_cents -= @challenge.stake*100
    current_user.save
    @challenge.status = "accepted"

    @challenge.create_activity key: 'challenge.accepted', owner: current_user
    # sends automated message
    @chatroom = Chatroom.new
    @chatroom = @chatroom.find_chatroom_for_destroy(@chatroom, current_user, @challenge.host)
    @message = Message.new
    @message = @message.new_challenge_message(@message, current_user, @chatroom, @challenge)

    if @challenge.save
      redirect_to chatroom_messages_path(@chatroom)
    else
      raise
    end
  end

  # def leave
  #     @challenge.guest.nil?
  #     @challenge.guest.balance_cents += @challenge.stake*100
  #     @challenge.guest = nil
  #     @challenge.status = "open"
  #     @challenge.guest.save
  #     @challenge.save
  # end

  def guest_left
    @challenge = Challenge.find(params[:challenge_id])
    # sends automated message
    @chatroom = Chatroom.new
    @chatroom = @chatroom.find_chatroom(@chatroom, current_user, @challenge.host)
    @message = Message.new
    @message = @message.guest_left_message(@message, current_user, @chatroom, @challenge)
    # sets guest to nil
    @challenge.guest.balance_cents += @challenge.stake*100
    @challenge.guest.save
    @challenge.guest = nil
    @challenge.status = "open"
    @challenge.save
    redirect_to challenges_path
  end

  helper_method :leave

  def host_win
    @challenge = Challenge.find(params[:challenge_id])
    if current_user == @challenge.host
      @challenge.Hostresponse = @challenge.host
    else
      @challenge.Guestresponse = @challenge.host
    end
    check_match
    @challenge.status = "played"
    @challenge.host.balance_cents += @challenge.stake*100
    @challenge.host.save
    @challenge.create_activity key: 'challenge.won', owner: @challenge.host
    redirect_to challenges_path
  end

  def host_lost
    @challenge = Challenge.find(params[:challenge_id])
    if current_user == @challenge.host
      @challenge.Hostresponse = @challenge.guest
    else
      @challenge.Guestresponse = @challenge.guest
    end
    check_match
    @challenge.status = "played"
    @challenge.guest.balance_cents += @challenge.stake*100
    @challenge.guest.save
    @challenge.create_activity key: 'challenge.won', owner: @challenge.guest
    redirect_to challenges_path
  end

  def add_time
    @challenge.time_remaining += 24.hours
    @challenge.save
    redirect_to challenge_path(@challenge)
  end

  def my_challenges
    @accepted_challenges = Challenge.where(guest_id: current_user.id)
    @hosted_challenges = Challenge.where(host_id: current_user.id)
    @closed_challenges = Challenge.where(host_id: current_user.id).or(Challenge.where(guest_id: current_user.id)).where(status: 'closed')
  end

  private

  def strong_params
    params.require(:challenge).permit(:host_gamertag, :stake, :game, :platform, :guest_id, :description)
  end

  def find_challenge
    @challenge = Challenge.find(params[:id])
  end

  def join_email
    UserMailer.guest_join(self).deliver_now
  end

  def check_status
    @challenge.status != "accepted" || @challenge.status != "played"
  end
  def check_match
    if @challenge.Hostresponse == @challenge.Guestresponse
      @challenge.winner_id = @challenge.Hostresponse
    elsif @challenge.Hostresponse.nil? || @challenge.Guestresponse.nil?
      return
    elsif @challenge.Hostresponse != @challenge.Guestresponse
      redirect_to new_dispute_path
    end
  end
end
