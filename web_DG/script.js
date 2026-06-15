
function temporarySwap(img, leftSrc, rightSrc, e) {
    const rect = img.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const side = x < rect.width / 2 ? 'left' : 'right';

    const original = img.src;
    img.src = side === 'left' ? leftSrc : rightSrc;

    setTimeout(() => {
        img.src = original;
    }, 100);
}

const bigBtn = document.querySelector('.botaogrande img');

bigBtn.parentElement.addEventListener('click', (e) => {
    temporarySwap(
        bigBtn,
        'assets/botao-dir.webp',
        'assets/botao-esq.webp',
        e
    );
});

const criarPeixeBtn = document.querySelector('.criarpeixe-btn');
const criarPeixeImg = document.querySelector('.criarpeixe-img');

criarPeixeBtn.addEventListener('click', (e) => {
    const rect = criarPeixeBtn.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const side = x < rect.width / 2 ? 'left' : 'right';

    if (side === 'left') {
        criarPeixeImg.src = 'assets/criarpeixe-dark.webp';
    } else {
        criarPeixeImg.src = 'assets/criarpeixe.webp';
    }

    setTimeout(() => {
        criarPeixeImg.src = 'assets/criarpeixe.webp';
    }, 100);
});

const modoBtn = document.querySelector('.modo img');

let isRio = true;

modoBtn.parentElement.addEventListener('click', () => {
    isRio = !isRio;

    modoBtn.src = isRio
        ? 'assets/botaorio.webp'
        : 'assets/botaomar.webp';
});
