import Typed from 'typed.js';

const initTyped = () => {
	var options = {
		strings: [", select…", ", rent…", ", chill!"],
		typeSpeed: 40,
		loop: true
	}

	var typed = new Typed("#typed", options);
};

export default initTyped;
