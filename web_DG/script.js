const filePath = "../scraping/useableData.json";
const bg_area = document.querySelector("html");
const modo = document.querySelector(".modo-label");
const hora = document.getElementById("hora");
const dia_de_hoje = document.getElementById("dia_de_hoje");

const caudal_afluente = document.getElementById("caudal_afluente");
const caudal_efluente = document.getElementById("caudal_efluente");

let cA1, cA2, cA3;
let cE1, cE2, cE3;

let date_now, time_now;

bg_area.style.backgroundSize = "cover";
bg_area.style.backgroundPosition = "center";
bg_area.style.backgroundRepeat = "no-repeat";

let bg_img_light = "url('assets/light.webp')";
let bg_img_medium = "url('assets/medium.webp')";
let bg_img_dark = "url('assets/dark.webp')";

let bg_img;

fetch(filePath)
  .then((response) => {
    return response.json(); //parse json
  })
  .then((data) => {
    console.log(`Data: ${data.date}`);
    date_now = data.date;
    console.log(`Hora: ${data.time}`);
    time_now = data.time;
    console.log(`Aguieira Caudal A.: ${data.aguieira[0]["Caudal Afluente"]}`);

    let sum =
      data.aguieira[0]["Caudal Afluente"] + data.raiva[0]["Caudal Afluente"];

    if (sum >= 720) {
      bg_img = bg_img_light;
    } else if (sum >= 360) {
      bg_img = bg_img_medium;
    } else {
      bg_img = bg_img_dark;
    }

    cA1 = data.aguieira[0]["Caudal Afluente"];
    cA2 = data.raiva[0]["Caudal Afluente"];
    cA3 = data.coimbra[0]["Caudal Afluente"];

    cE1 = data.aguieira[0]["Caudal Efluente"];
    cE2 = data.raiva[0]["Caudal Efluente"];
    cE3 = data.coimbra[0]["Caudal Efluente"];

    bg_area.style.backgroundImage = bg_img;
    hora.innerHTML = time_now;
    dia_de_hoje.innerHTML = date_now;
    caudal_afluente.innerHTML = cA1;
    caudal_efluente.innerHTML = cE1;
  })
  .catch((error) => {
    console.error("error fetching JSON:", error);
  });

let info_mode = 0;

function updateModoText() {
  if (info_mode == 0) {
    //AGUIEIRA
    modo.innerHTML = "AGUIEIRA";
    caudal_afluente.innerHTML = cA1;
    caudal_efluente.innerHTML = cE1;
  } else if (info_mode == 1) {
    //RAIVA
    modo.innerHTML = "RAIVA";
    caudal_afluente.innerHTML = cA2;
    caudal_efluente.innerHTML = cE2;
  } else {
    //COIMBRA
    modo.innerHTML = "COIMBRA";
    caudal_afluente.innerHTML = cA3;
    caudal_efluente.innerHTML = cE3;
  }
}

updateModoText();

function temporarySwap(img, leftSrc, rightSrc, e) {
  const rect = img.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const side = x < rect.width / 2 ? "left" : "right";

  const original = img.src;

  if (side === "left") {
    img.src = leftSrc;
  } else {
    img.src = rightSrc;
  }

  setTimeout(() => {
    img.src = original;
  }, 100);
}

const bigBtn = document.querySelector(".botaogrande img");

bigBtn.parentElement.addEventListener("click", (e) => {
  temporarySwap(bigBtn, "assets/botao-dir.webp", "assets/botao-esq.webp", e);
  info_mode++;
  if (info_mode == 3) {
    info_mode = 0;
  }
  console.log(info_mode);

  updateModoText();
});

const criarPeixeBtn = document.querySelector(".criarpeixe-btn");
const criarPeixeImg = document.querySelector(".criarpeixe-img");

/*criarPeixeBtn.addEventListener("click", (e) => {
  const rect = criarPeixeBtn.getBoundingClientRect();
  const x = e.clientX - rect.left;
  const side = x < rect.width / 2 ? "left" : "right";

  if (side === "left") {
    criarPeixeImg.src = "assets/criarpeixe-dark.webp";
  } else {
    criarPeixeImg.src = "assets/criarpeixe.webp";
  }

  setTimeout(() => {
    criarPeixeImg.src = "assets/criarpeixe.webp";
  }, 100);
});
*/

const modoBtn = document.querySelector(".modo img");

let isRio = true;
