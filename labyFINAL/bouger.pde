void bougeMommie(int SIZE, int etage){
  int wallW=width/LAB_SIZE;
  int wallH=height/LAB_SIZE;
 
  if(dx==0 && dy==1){
    pushMatrix();
      translate(mx*wallW,my*wallH, -35);
      rotateX(-PI/2);
      //rotateY(PI);
      scale(0.1);
      shape(mommie);
      popMatrix();
  }else if (dx==-1 && dy==0){
    pushMatrix();
    translate(mx*wallW,my*wallH, -35);
    rotateX(-PI/2);
    rotateY(-PI/2);
    scale(0.1);
    shape(mommie);
    popMatrix(); 
  }else if(dx==1 && dy==0){
    pushMatrix();
    translate(mx*wallW,my*wallH, -35);
    rotateX(-PI/2);
    rotateY(PI/2);
    scale(0.1);
    shape(mommie);
    popMatrix(); 
  }else if (dx==0 && dy==-1){
      pushMatrix();
      translate(mx*wallW,my*wallH, -35);
      rotateX(-PI/2);
      rotateY(PI);
      scale(0.1);
      shape(mommie);
      popMatrix();
  }
  if(my+dy>=0 && my+dy<SIZE && mx+dx>=0 && mx+dx<SIZE &&
    labyrinthe[etage][my+dy][mx+dx]!='#' && dx==0 && dy==1){
       my=((frameCount/100)-(mx))%(SIZE-1);
       //println("boucle 1 mx= "+ mx+ " my= "+my);
    }
    else if(my+dy>=0 && my+dy<SIZE-1 && mx+dx>=0 && mx+dx<SIZE-1 &&
    labyrinthe[etage][my+dy][mx+dx]!='#' && dx==1 && dy==0){
        mx=((frameCount/100)-(my))%(SIZE-1);
       // println("boucle 2 mx+dx= "+ (mx+dx)+ " my+dy= "+(my+dy));
        if(my+dy<0 || my+dy>SIZE || mx+dx<0 || mx+dx>SIZE-1){
          dy=int(random(-2,2));
          dx=int(random(-2,2));
        }
        
    }
    
    else if(my+dy>=0 && my+dy<SIZE && mx+dx>=0 && mx+dx<SIZE &&
    labyrinthe[etage][my+dy][mx+dx]!='#' && dx==0 && dy==-1){
        my=((frameCount/100)-(mx+count1))%(SIZE-1);
        count1++;
       // println("count1 : "+count1);
        //println("boucle 3 mx= "+ mx+ " my= "+my);
    }
    else if(my+dy>=0 && my+dy<SIZE && mx+dx>=0 && mx+dx<SIZE &&
        labyrinthe[etage][my+dy][mx+dx]!='#' && dx==-1 && dy==0){
        mx=((frameCount/100)-(my+count2))%(SIZE-1);
        count2++;
        //println("count2 : "+count2);
        //println("boucle 4 mx= "+ mx+ " my= "+my);
    }
   if(my+dy<0 || my+dy>=SIZE-1 || mx+dx<0 || mx+dx>=SIZE-1 || labyrinthe[etage][my+dy][mx+dx]=='#' || (dy==0 && dx==0) || (dy==1 && dx==1) || (dy==-1 && dx==-1)){
     // println("enter and dx= "+ dx + "dy "+ dy);
      dy=int(random(-2,2));
      dx=int(random(-2,2));
      if(dx==-1 && dy==0) count2=0;
      if(dx==0 && dy==-1) count1=0;
      //println("enter and dx= "+ dx + " dy "+ dy);
      // println("boucle 2 my = "+ my+ ", mx= "+mx);
    }
   // println((frameCount/50));
    
    
  
  
}
