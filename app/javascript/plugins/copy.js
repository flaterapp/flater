function copy(text) {
      var t = document.getElementById('t')
      t.innerHTML = text
      t.select()
      try {
        var successful = document.execCommand('copy')
        var msg = successful ? 'successfully' : 'unsuccessfully'
        console.log('text coppied ' + msg)
      } catch (err) {
        console.log('Unable to copy text')
      }
      t.innerHTML = ''
    }

export { copy };
