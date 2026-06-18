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
		document.body.style.overflow = 'hidden';
		document.documentElement.style.overflow = 'hidden';
	}

	function closeLightbox() {
		root.hidden = true;
		if (img) {
			img.removeAttribute('src');
			img.alt = '';
		}
		if (caption) {
			caption.textContent = '';
		}
		document.body.style.overflow = '';
		document.documentElement.style.overflow = '';
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
})();
