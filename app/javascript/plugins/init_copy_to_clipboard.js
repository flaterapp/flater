import { addFlashMessage } from './init_flash_messages';

const initCopyToClipboard = () => {
	const inputCopy = document.querySelectorAll('.inputCopy');
	// const buttonCopy = document.querySelector('.btnCopy')
	inputCopy.forEach((input) => {
		input.addEventListener("click", () => {
			copy(input);
		})
	})

  const btnCopy = document.querySelectorAll('.btn-copy');
  btnCopy.forEach((btn) => {
    btn.addEventListener("click", () => {
      const input = btn.parentNode.parentNode.querySelector('.inputCopy');
      copy(input);
    })
  })
};

const copy = (inputNode) => {
  inputNode.select();
  document.execCommand('copy');
  window.getSelection().removeAllRanges();
  addFlashMessage('Copied', 'primary');
}

export { initCopyToClipboard };
