const addFlashMessage = (text, className) => {
	const existingAlert = document.querySelector('p.alert')
	if (existingAlert) {
		existingAlert.remove();
	}
	const html = `<p class="alert alert-${className}">${text}</p>`;
	document.querySelector('body').insertAdjacentHTML('afterbegin', html);
}

export { addFlashMessage };