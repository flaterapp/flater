import Typed from 'typed.js';

const initTyped = () => {
	const typedElem = document.querySelector('#typed')
		
	if (typedElem == null)
	return

	const strings = JSON.parse((typedElem.dataset.strings))
	
	var options = {
		strings: strings,
		typeSpeed: 40,
		loop: true
	}

	var typed = new Typed(typedElem, options);
};

export default initTyped;
