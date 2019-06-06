import { addFlashMessage } from './init_flash_messages';

const initCopyToClipboard = () => {
	const inputCopy = document.querySelectorAll('.inputCopy');
	// const buttonCopy = document.querySelector('.btnCopy')
	inputCopy.forEach((input) => {
		input.addEventListener("click", () => {
			input.select();
			document.execCommand('copy');
			window.getSelection().removeAllRanges();
			addFlashMessage('Copied', 'primary');
		})
	})
};

export { initCopyToClipboard };
