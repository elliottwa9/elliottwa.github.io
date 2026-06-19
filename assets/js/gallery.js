(function () {
	var root = document.querySelector('[data-gallery-lightbox]');
	if (!root) return;

	var img = root.querySelector('.gallery-lightbox__img');
	var caption = root.querySelector('.gallery-lightbox__caption');
	var closeEls = root.querySelectorAll('[data-gallery-close]');

	function openLightbox(src, label) {
		if (!img) return;
		img.src = src;
		img.alt = label || '';
		if (caption) {
			caption.textContent = label || '';
			caption.hidden = !label;
		}
		root.hidden = false;
		requestAnimationFrame(function () {
			root.classList.add('is-open');
		});
		document.body.style.overflow = 'hidden';
		document.documentElement.style.overflow = 'hidden';
	}

	function closeLightbox() {
		root.classList.remove('is-open');
		document.body.style.overflow = '';
		document.documentElement.style.overflow = '';
		function handler(e) {
			if (e.target !== root || e.propertyName !== 'opacity') return;
			root.removeEventListener('transitionend', handler);
			root.hidden = true;
			if (img) {
				img.removeAttribute('src');
				img.alt = '';
			}
			if (caption) caption.textContent = '';
		}
		root.addEventListener('transitionend', handler);
	}

	document.querySelectorAll('[data-gallery-open]').forEach(function (btn) {
		btn.addEventListener('click', function () {
			var full = btn.getAttribute('data-full-src');
			var cap = btn.getAttribute('data-caption') || '';
			if (full) openLightbox(full, cap);
		});
	});

	closeEls.forEach(function (el) {
		el.addEventListener('click', function (e) {
			e.preventDefault();
			closeLightbox();
		});
	});

	document.addEventListener('keydown', function (e) {
		if (e.key === 'Escape' && !root.hidden) {
			closeLightbox();
		}
	});

	// Wait for every image in a section to load, then reveal them all at once
	document.querySelectorAll('.category-section').forEach(function (section) {
		var triggers = Array.from(section.querySelectorAll('.gallery-item__trigger'));
		if (triggers.length === 0) return;

		var pending = triggers.length;

		function onReady() {
			pending--;
			if (pending <= 0) {
				triggers.forEach(function (t) { t.classList.add('is-loaded'); });
			}
		}

		triggers.forEach(function (trigger) {
			var image = trigger.querySelector('.gallery-item__img');
			if (!image) { onReady(); return; }
			if (image.complete && image.naturalWidth > 0) {
				onReady();
			} else {
				image.addEventListener('load', onReady);
				image.addEventListener('error', onReady);
			}
		});
	});
})();
