import Typed from 'typed.js';

const initTyped = () => {
	const typedElem = document.querySelector('#typed')
		
	if (typedElem == null)
	return

	const strings = JSON.parse(typedElem.dataset.strings)
	const typeSpeed = JSON.parse(typedElem.dataset.speed)
	const loop = JSON.parse(typedElem.dataset.loop)
	
	var options = {
		strings: strings,
		typeSpeed: typeSpeed,
		loop: loop
	}

	var typed = new Typed(typedElem, options);
};

export default initTyped;
