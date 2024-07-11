int frameCount = 0;
boolean closeUp = false;
float[] birdX = new float[5];
float[] birdY = new float[5];
float[] birdScale = new float[5];
float[] birdYSpeed = new float[5];
boolean[] birdGrowing = new boolean[5];
float birdSpeed = 2;
float zoomFactor = 1.0;
float rowboatX = 50;
float rowboatY = 500;
float rowboatSpeed = 2.5;
float oilLeakX = 500;
float oilLeakY = 300;

void setup() {
  size(800, 600);
  frameRate(30);
  initializeBirds();
}

void draw() {
  background(135, 206, 235); // Warna langit
  
  if (frameCount < 450) {
    drawMediumShot();
  } else if (frameCount < 900) {
    drawBudiRowing();
  } else if (frameCount < 1350) {
    drawOilLeakCloseUp();
  } else {
    frameCount = 0; // Reset untuk looping animasi
    rowboatX = 50; // Reset posisi perahu
    zoomFactor = 1.0; // Reset zoom
  }
  
  frameCount++;
}

void initializeBirds() {
  for (int i = 0; i < birdX.length; i++) {
    birdX[i] = random(-50, width / 2); // Memulai di luar layar di sebelah kiri
    birdY[i] = random(100, 300); // Posisi vertikal acak
    birdScale[i] = random(0.5, 1.5); // Ukuran acak
    birdYSpeed[i] = random(-0.5, 0.5); // Kecepatan vertikal acak
    birdGrowing[i] = random(1) > 0.5; // Acak pertumbuhan (true: membesar, false: mengecil)
  }
}

void drawMediumShot() {
  // Laut
  fill(0, 105, 148);
  rect(0, height - 200, width, 200);
  
  // Pantai
  fill(255, 228, 181);
  rect(0, height - 200, width, 100);
  
  // Kapal besar yang bocor
  drawShip(oilLeakX, oilLeakY);
  
  // Burung-burung terbang
  for (int i = 0; i < birdX.length; i++) {
    drawBird(birdX[i], birdY[i], birdScale[i]);
    updateBird(i);
  }
  
  // Budi
  drawPerson(width / 2, height - 250);
}

void drawBudiRowing() {
  // Laut
  fill(0, 105, 148);
  rect(0, height - 200, width, 200);
  
  // Budi mendayung perahu
  drawRowboat(rowboatX, rowboatY);
  rowboatX += rowboatSpeed;
  
  // Kapal besar yang bocor
  drawShip(oilLeakX, oilLeakY);
}

void drawOilLeakCloseUp() {
  // Latar belakang laut
  fill(0, 105, 148);
  rect(0, 0, width, height);
  
  // Kapal besar yang bocor (close-up)
  drawOilLeak(oilLeakX, oilLeakY);
}

void drawShip(float x, float y) {
  fill(160, 82, 45);
  rect(x - 150, y - 50, 300, 100);
  fill(128, 128, 128);
  rect(x - 100, y - 100, 200, 50);
  
  // Minyak bocor dari kapal
  drawOilLeak(x, y + 50);
}

void drawOilLeak(float x, float y) {
  fill(0);
  noStroke();
  beginShape();
  vertex(x - 10, y);
  vertex(x - 5, y + 30);
  vertex(x + 5, y + 60);
  vertex(x + 10, y + 90);
  vertex(x - 10, y + 120);
  endShape(CLOSE);
}

void drawRowboat(float x, float y) {
  fill(139, 69, 19);
  rect(x - 20, y - 10, 40, 20);
  
  // Budi mendayung
  drawPerson(x, y - 20);
}

void drawBird(float x, float y, float scale) {
  fill(0);
  noStroke();
  beginShape();
  vertex(x, y);
  vertex(x + 10 * scale, y - 5 * scale); // Tipiskan sayap
  vertex(x + 20 * scale, y);
  vertex(x + 30 * scale, y - 5 * scale); // Tipiskan sayap
  vertex(x + 40 * scale, y);
  endShape(CLOSE);
}

void drawPerson(float x, float y) {
  // Kepala
  fill(255, 220, 185);
  ellipse(x, y - 20, 20, 20);
  
  // Badan
  stroke(0);
  strokeWeight(2);
  line(x, y, x, y + 20);
  
  // Tangan
  line(x, y + 10, x - 10, y + 10);
  line(x, y + 10, x + 10, y + 10);
  
  // Kaki
  line(x, y + 20, x - 5, y + 40);
  line(x, y + 20, x + 5, y + 40);
}

void updateBird(int index) {
  // Pergerakan horizontal
  birdX[index] += birdSpeed;
  // Pergerakan vertikal
  birdY[index] += birdYSpeed[index];
  
  // Mengatur batas vertikal
  if (birdY[index] < 50 || birdY[index] > height - 200) {
    birdYSpeed[index] *= -1; // Ubah arah saat mencapai batas atas atau bawah
  }
  
  if (birdX[index] > width) {
    birdX[index] = -50; // Reset ke luar layar sebelah kiri
    birdY[index] = random(100, 300); // Posisi vertikal acak
    birdScale[index] = random(0.5, 1.5); // Reset ukuran acak
    birdYSpeed[index] = random(-0.5, 0.5); // Reset kecepatan vertikal acak
    birdGrowing[index] = random(1) > 0.5; // Reset pertumbuhan acak
  }
  
  // Perubahan ukuran
  if (birdGrowing[index]) {
    birdScale[index] += 0.01;
    if (birdScale[index] > 1.5) {
      birdGrowing[index] = false;
    }
  } else {
    birdScale[index] -= 0.01;
    if (birdScale[index] < 0.5) {
      birdGrowing[index] = true;
    }
  }
}
