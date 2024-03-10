
  PShape laby00[];
  PShape laby11[];
  PShape ceiling00[];
  PShape ceiling11[];
  char labyrinthe1[][][];
  char sides1[][][][]; 
  





void Laby(int etage, int SIZE,int hauteur, int largeur){
  float wallW = width/LAB_SIZE;
  float wallH = height/LAB_SIZE;

 
int todig = 0;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      sides1[etage][j][i][0] = 0;
      sides1[etage][j][i][1] = 0;
      sides1[etage][j][i][2] = 0;
      sides1[etage][j][i][3] = 0;
      if (j%2==1 && i%2==1) {
        labyrinthe1[etage][j][i] = '.';
        todig ++;
      } else
        labyrinthe1[etage][j][i] = '#';
    }
  }
  int gx = 1;
  int gy = 1;
  while (todig>0 ) {
    int oldgx = gx;
    int oldgy = gy;
    int alea = floor(random(0, 4)); // selon un tirage aleatoire
    if      (alea==0 && gx>1)          gx -= 2; // le fantome va a gauche
    else if (alea==1 && gy>1)          gy -= 2; // le fantome va en haut
    else if (alea==2 && gx<SIZE-2) gx += 2; // .. va a droite
    else if (alea==3 && gy<SIZE-2) gy += 2; // .. va en bas

    if (labyrinthe1[etage][gy][gx] == '.') {
      todig--;
      labyrinthe1[etage][gy][gx] = ' ';
      labyrinthe1[etage][(gy+oldgy)/2][(gx+oldgx)/2] = ' ';
    }
  }
  labyrinthe1[etage][0][1]                   = ' '; // entree
  labyrinthe1[etage][SIZE-2][SIZE-1] = 's'; // sortie

  for (int j=1; j<SIZE-1; j++) {
    for (int i=1; i<SIZE-1; i++) {
      if ((labyrinthe1[etage][j][i]==' ' || labyrinthe1[etage][j][i]=='s')) {
        if (labyrinthe1[etage][j-1][i]=='#' && (labyrinthe1[etage][j+1][i]==' ' || labyrinthe1[etage][j+1][i]=='s') &&
          labyrinthe1[etage][j][i-1]=='#' && labyrinthe1[etage][j][i+1]=='#')
          sides1[etage][j-1][i][0] = 1;// c'est un bout de couloir vers le haut 
        if ((labyrinthe1[etage][j-1][i]==' ' || labyrinthe1[etage][j-1][i]=='s')  && labyrinthe1[etage][j+1][i]=='#' &&
          labyrinthe1[etage][j][i-1]=='#' && labyrinthe1[etage][j][i+1]=='#')
          sides1[etage][j+1][i][3] = 1;// c'est un bout de couloir vers le bas 
        if (labyrinthe1[etage][j-1][i]=='#' && labyrinthe1[etage][j+1][i]=='#' &&
          (labyrinthe1[etage][j][i-1]==' ' || labyrinthe1[etage][j][i-1]=='s') && labyrinthe1[etage][j][i+1]=='#')
          sides1[etage][j][i+1][1] = 1;// c'est un bout de couloir vers la droite
        if (labyrinthe1[etage][j-1][i]=='#' && labyrinthe1[etage][j+1][i]=='#' &&
          labyrinthe1[etage][j][i-1]=='#' && (labyrinthe1[etage][j][i+1]==' ' || labyrinthe1[etage][j][i+1]=='s'))
          sides1[etage][j][i-1][2] = 1;// c'est un bout de couloir vers la gauche
      }
    }
  }
  
  
 
  
  ceiling00[etage] = createShape();
  ceiling11[etage] = createShape();
  
  ceiling11[etage].beginShape(QUADS);
  ceiling00[etage].beginShape(QUADS);
  
  laby00[etage] = createShape();
  laby00[etage].beginShape(QUADS);
  laby00[etage].texture(texture0);
  laby00[etage].noStroke();
  
  
  
  laby11[etage] = createShape();
  laby11[etage].beginShape(QUADS);
  laby11[etage].texture(texture1);
  laby11[etage].noStroke();
  //laby00.stroke(255, 32);
  //laby00.strokeWeight(0.5);
  
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      if (labyrinthe1[etage][j][i]=='#') {
        laby00[etage].fill(i*25, j*25, 255-i*10+j*10);
        if (j==0 || (labyrinthe1[etage][j-1][i]==' ' || labyrinthe1[etage][j-1][i]=='s') ) {
          laby00[etage].normal(0, -1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              //float d1 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k==0)  d1=0;
              //if (l==-WALLD) d1=-2*abs(d1);
              laby00[etage].vertex((i*wallW-wallW/2+(k+0)*wallW/WALLD)-largeur, (j*wallH-wallH/2)-largeur, ((l+0)*50/WALLD)+hauteur, k/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d2 =15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+0))-0.5);
              //if (k+1==WALLD ) d2=0;
              //if (l==-WALLD) d2=-2*abs(d2);
              laby00[etage].vertex((i*wallW-wallW/2+(k+1)*wallW/WALLD)-largeur, (j*wallH-wallH/2)-largeur, ((l+0)*50/WALLD)+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+l/2.0/WALLD)*texture0.height);
              
              //float d3 = 15*(noise(0.3*(i*WALLD+(k+1)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k+1==WALLD ||l+1==WALLD) d3=0;
              laby00[etage].vertex((i*wallW-wallW/2+(k+1)*wallW/WALLD)-largeur, (j*wallH-wallH/2)-largeur, ((l+1)*50/WALLD)+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              
              //float d4 = 15*(noise(0.3*(i*WALLD+(k+0)), 0.3*(j*WALLD), 0.3*(l+1))-0.5);
              //if (k==0 ||l+1==WALLD) d4=0;
              laby00[etage].vertex((i*wallW-wallW/2+(k+0)*wallW/WALLD)-largeur, (j*wallH-wallH/2)-largeur, ((l+1)*50/WALLD)+hauteur, k/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }

        if (j==SIZE-1 || (labyrinthe1[etage][j+1][i]==' ' || labyrinthe1[etage][j+1][i]=='s')) {
          laby00[etage].normal(0, 1, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby00[etage].vertex((i*wallW-wallW/2+(k+0)*wallW/WALLD)-largeur, (j*wallH+wallH/2)-largeur, (l+1)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2+(k+1)*wallW/WALLD)-largeur, (j*wallH+wallH/2)-largeur, (l+1)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2+(k+1)*wallW/WALLD)-largeur, (j*wallH+wallH/2)-largeur, (l+0)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2+(k+0)*wallW/WALLD)-largeur, (j*wallH+wallH/2)-largeur, (l+0)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==0 || (labyrinthe1[etage][j][i-1]==' ' || labyrinthe1[etage][j][i-1]=='s')) {
          laby00[etage].normal(-1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2+(k+0)*wallW/WALLD)-largeur, (l+1)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2+(k+1)*wallW/WALLD)-largeur, (l+1)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2+(k+1)*wallW/WALLD)-largeur, (l+0)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2+(k+0)*wallW/WALLD)-largeur, (l+0)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
            }
        }

        if (i==SIZE-1 || (labyrinthe1[etage][j][i+1]==' ' || labyrinthe1[etage][j][i+1]=='s')) {
          laby00[etage].normal(1, 0, 0);
          for (int k=0; k<WALLD; k++)
            for (int l=-WALLD; l<WALLD; l++) {
              laby00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2+(k+0)*wallW/WALLD)-largeur, (l+0)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2+(k+1)*wallW/WALLD)-largeur, (l+0)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+0)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2+(k+1)*wallW/WALLD)-largeur, (l+1)*50/WALLD+hauteur, (k+1)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
              laby00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2+(k+0)*wallW/WALLD)-largeur, (l+1)*50/WALLD+hauteur, (k+0)/(float)WALLD*texture0.width, (0.5+(l+1)/2.0/WALLD)*texture0.height);
            }
        }
        ceiling11[etage].fill(32, 255, 0);
        ceiling11[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2)-largeur, 50+hauteur);
        ceiling11[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2)-largeur, 50+hauteur);
        ceiling11[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH+wallH/2)-largeur, 50+hauteur);
        ceiling11[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH+wallH/2)-largeur, 50+hauteur);        
      } else {
          laby11[etage].noStroke(); //grounds
          laby11[etage].normal(0,0,1);
          laby11[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2)-largeur, -50+hauteur, (0)/(float)WALLD*texture1.width, (0.5+(0)/2.0/WALLD)*texture1.height);
          laby11[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2)-largeur, -50+hauteur, (1)/(float)WALLD*texture1.width, (0.5+(0)/2.0/WALLD)*texture1.height);
          laby11[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH+wallH/2)-largeur, -50+hauteur, (1)/(float)WALLD*texture1.width, (0.5+(1)/2.0/WALLD)*texture1.height);
          laby11[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH+wallH/2)-largeur, -50+hauteur, (0)/(float)WALLD*texture1.width, (0.5+(1)/2.0/WALLD)*texture1.height);
        ceiling00[etage].fill(32); // top of walls
        ceiling00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH-wallH/2)-largeur, 50+hauteur);
        ceiling00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH-wallH/2)-largeur, 50+hauteur);
        ceiling00[etage].vertex((i*wallW+wallW/2)-largeur, (j*wallH+wallH/2)-largeur, 50+hauteur);
        ceiling00[etage].vertex((i*wallW-wallW/2)-largeur, (j*wallH+wallH/2)-largeur, 50+hauteur);
      }
    }
  }
  laby11[etage].endShape();
  laby00[etage].endShape();
  ceiling00[etage].endShape();
  ceiling11[etage].endShape();
}

void newLaby(int etage, int SIZE){ 
  //println(SIZE);
   wallW = width/SIZE;
   wallH = height/SIZE;
  for (int j=0; j<SIZE; j++) {
    for (int i=0; i<SIZE; i++) {
      pushMatrix();
      translate(i*wallW, j*wallH, 0);
      if (labyrinthe1[etage][j][i]=='#') {
        beginShape(QUADS);
        if (sides1[etage][j][i][3]==1) {
          pushMatrix();
          translate(0, -wallH/2, 40+Hauteur);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            //sphere(15);
          }
          popMatrix();
        }

        if (sides1[etage][j][i][0]==1) {
          pushMatrix();
          translate(0, wallH/2, 40+Hauteur);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            //sphere(15);
          }
          popMatrix();
        }
         
         if (sides1[etage][j][i][1]==1) {
          pushMatrix();
          translate(-wallW/2, 0, 40+Hauteur);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            //sphere(15);
          }
          popMatrix();
        }
         
        if (sides1[etage][j][i][2]==1) {
          pushMatrix();
          translate(0, wallH/2, 40+Hauteur);
          if (i==posX || j==posY) {
            fill(i*25, j*25, 255-i*10+j*10);
            sphere(5);              
            //spotLight(i*25, j*25, 255-i*10+j*10, 0, -15, 15, 0, 0, -1, PI/4, 1);
          } else {
            fill(128);
            //sphere(15);
          }
          popMatrix();
        }
      } 
      popMatrix();
    }
    if (outlab){
        shape(laby11[etage], 0, 0);
        shape(laby00[etage], 0, 0);
        //if(SIZE==21) 
        shape(sand,0,0);
        shape(ceiling00[etage], 0, 1);    
    }

  }
}
