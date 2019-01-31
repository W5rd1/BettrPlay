function scrollLastMessageIntoView() {
  var messages = document.querySelectorAll('.message-content');
  var lastMessage = messages[messages.length - 1];


  if (lastMessage !== undefined) {
    lastMessage.scrollIntoView(false);
  }
}

// console.log('blah')
