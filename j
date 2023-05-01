#include <stdio.h>
#include <unistd.h>  
#include <fcntl.h>  
#include <errno.h>   
#include <termios.h>  
#include <string.h>  
#include <sys/ioctl.h>
#include <stdint.h> 
#include "serie.h"
#include <stdlib.h>
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <SDL/SDL_ttf.h>
#include "functions.h"
#include "SDL_rotozoom.h"
#include <time.h>
//#include "maze.h"
#define MAZECOIN_WIDTH 20
#define MAZECOIN_HEIGHT 20
#define MAZECOIN_MAX_NUM 52


int main()
{
	//TTF_Init();
	SDL_Surface *screen=NULL;
        SDL_Rect camera5, posperso;
	minimap m1,m2,m3;
        temps t,te; 
        int collision1=0;
	int redimensionnement=8.4;
	animation1 mat[1][3];
	init_map(&m1);
	init_map2(&m2);
	init_map3(&m3);
	camera5.x = 0;
    	camera5.y = 0;
    	camera5.w = 1500;
    	camera5.h = 750;  
	initialiser_temps(&t); 
	initialiser_temp(&te);
	initialiseranimation(mat);



	
	image IMAGE,LOGO,BACKOP,BACKPLAY,BACKPLAY2,BACKPLAY3,IMAGE_BTN1, IMAGE_BTN2, IMAGE_BTN3,IMAGE_BTN4,IMAGE_BTN5,IMAGE_BTN6,IMAGE_BTN7,IMAGE_BTN8,IMAGE_BTN9,IMAGE_BTN10,IMAGE_BTN11,
        IMAGE_BTN12,IMAGE_BTN13,IMAGE_BTN14,IMAGE_BTN15,IMAGE_BTN16,IMAGE_BTN17,IMAGE_BTN18,IMAGE_BTN19,IMAGE_BTN20,IMAGE_BTN21,COIN,Masque1,Masque2,Masque3,INPUT,TEEMO;
        animation Backg;
        animation2 Coin;
	Mix_Music *music=NULL;
	Mix_Chunk *mus=NULL,*muse=NULL,*muse2=NULL,*muse3=NULL,*muse4=NULL;
	text txte,txte1,txte2,txte3,txte4;
	Uint8* keystates = SDL_GetKeyState(NULL);
        Personne p,p2;
	/////////////////////////////////
	enigme e;
	int enigmeIMAGE=0,BE=0,rep=-1,stage=0;
        ///////////////////////////////
	Enigme *ET,g;
        int TEST=-1;
	/////////////////////////////////
	Uint32 dt, t_prev;
	TTF_Font *police=NULL;
	SDL_Surface *text1=NULL,*text2=NULL,*number=NULL,*maze = NULL;
	FILE *f=NULL;
        //Masque1.img= IMG_Load("playbackmasque.png");
	//Masque2= IMG_Load("backplaymasque2.bmp");
	//Masque3= IMG_Load("backplaymasque3.bmp");

	SDL_Event event;
	int max1,max2,max3,tab[300];
	int detect=0,niveau=1,detect1=0,click=0,volume=250, posinit,detect2=0;
	int boucle=1,Mode=0,i=0,choixplayer=0,choixtype=0;
	//DECLARATION ENNEMI
	Ennemi E;
	int F,k;
	int collision=1;
	/////////////////////////////////////////////////////////////////////
	
//////////////////////////////////////////////////////////////:


	if(SDL_Init(SDL_INIT_VIDEO|SDL_INIT_AUDIO|SDL_INIT_TIMER )==-1)
	{
	printf("could not initialize SDL: %s.\n",SDL_GetError());
	return -1;
	}
	screen=SDL_SetVideoMode(1500,750,32,SDL_HWSURFACE | SDL_DOUBLEBUF);
	Mix_OpenAudio(44100,MIX_DEFAULT_FORMAT,2,2048);
	mus=Mix_LoadWAV("click.wav");
	muse=Mix_LoadWAV("motion.wav");
        muse2=Mix_LoadWAV("damage.wav");
        muse3=Mix_LoadWAV("jump.wav");
        muse4=Mix_LoadWAV("coin.wav");
        
	    initialiser_imageTEEMO(&TEEMO);
	    initialiser_imageINPUT(&INPUT);
	    initialiser_imageBACK(&IMAGE);
	    initialiser_imageBACKOP(&BACKOP);
	    initialiser_imageBACKPLAY(&BACKPLAY);
	    initialiser_imageBACKPLAY2(&BACKPLAY2);
	    initialiser_imageBACKPLAY3(&BACKPLAY3);
	    initialiser_imageBOUTON1(&IMAGE_BTN1);
	    initialiser_imageBOUTON2(&IMAGE_BTN2);
	    initialiser_imageBOUTON3(&IMAGE_BTN3);
	    initialiser_imageBOUTON4(&IMAGE_BTN4);
	    initialiser_imageBOUTON5(&IMAGE_BTN5);
	    initialiser_imageBOUTON6(&IMAGE_BTN6);
	    initialiser_imageBOUTON7(&IMAGE_BTN7);
	    initialiser_imageBOUTON8(&IMAGE_BTN8);
	    initialiser_imageBOUTON9(&IMAGE_BTN9);
	    initialiser_imageBOUTON10(&IMAGE_BTN10);
	    initialiser_imageBOUTON11(&IMAGE_BTN11);
	    initialiser_imageBOUTON12(&IMAGE_BTN12);
	    initialiser_imageBOUTON13(&IMAGE_BTN13);
	    initialiser_imageBOUTON14(&IMAGE_BTN14);
	    initialiser_imageBOUTON15(&IMAGE_BTN15);
	    initialiser_imageBOUTON16(&IMAGE_BTN16);
	    initialiser_imageBOUTON17(&IMAGE_BTN17);
	    initialiser_imageBOUTON18(&IMAGE_BTN18);
	    initialiser_imageBOUTON19(&IMAGE_BTN19);//C
	    initialiser_imageBOUTON20(&IMAGE_BTN20);//K
	    initialiser_imageBOUTON21(&IMAGE_BTN21);//M
            initialiser_coin(&COIN);
	    initialiser_audio(&music);
	    initialiser_audiobref(mus);
	    initialiser_texte(&txte);
	    initBackground(&Backg);
            init_coin(&Coin);
	   /* initPerso(&p);
	    initPerso(&p2);*/
	    initialiser_texte1(&txte1); 
            initialiser_texte2(&txte2); 
            initialiser_texte3(&txte3); 
            initialiser_texte4(&txte4);
            initEnnemi(&E);
            meilleur_score("score.txt",tab,max1,max2,max3);
            TTF_Init();
            SDL_EnableKeyRepeat(10,10);
	    //texte score :

    police = TTF_OpenFont("Trajan Pro.ttf", 35);
    SDL_Color blanco={255,255,255};
    text2= TTF_RenderText_Blended(police,"SCORE :",blanco);
    p.position_textee.x=15;
    p.position_textee.y=20;
   
    /////////////////////////////////////////gestion de score

	p.number[20];
	p.score=1000;
	sprintf(p.number, "%d",(p.score));

    ////////////////////////////////////////positions nombre :

    number= TTF_RenderText_Blended(police,p.number,blanco);
    p.position_number.x=170;
    p.position_number.y=20;
    TTF_CloseFont(police);
    
    //////////////////////////////////////////texte vie:

    police =TTF_OpenFont("Trajan Pro.ttf",35);
    SDL_Color blanc= {255,255,255};
    text1= TTF_RenderText_Blended(police,"VIE :",blanc);
    p.position_texte.x=19;
    p.position_texte.y=70;
    TTF_CloseFont(police);
    p.nb_vie=5;
	while(boucle)
	{
		if(niveau==1)
		{
			afficher_imageBMP(screen,IMAGE);
			afficher_imageBTN(screen,IMAGE_BTN1);
			afficher_imageBTN(screen,IMAGE_BTN2);
			afficher_imageBTN(screen,IMAGE_BTN3);
			afficher_imageBTN(screen,IMAGE_BTN15);
			if (detect==0)
			{
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN3);
				afficher_imageBTN(screen,IMAGE_BTN15);
			}
			if (detect==1)
			{
				afficher_imageBTN(screen,IMAGE_BTN4);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN3);
				afficher_imageBTN(screen,IMAGE_BTN15);
			}
			if (detect==2)
			{
				afficher_imageBTN(screen,IMAGE_BTN5);
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN3);
				afficher_imageBTN(screen,IMAGE_BTN15);
			}
			if (detect==3)
			{
				afficher_imageBTN(screen,IMAGE_BTN6);
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN15);
			}
			if (detect==4)
			{
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN3);
				afficher_imageBTN(screen,IMAGE_BTN16);
			}
			if (click==1)
			{
				afficher_imageBTN(screen,IMAGE_BTN7);
				afficher_imageBTN(screen,IMAGE_BTN15);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN3);
				SDL_UpdateRect(screen,0,0,0,0);
				SDL_Delay(1000);
				click=0;
			}
			if (click==2)
			{
				afficher_imageBTN(screen,IMAGE_BTN8);
				afficher_imageBTN(screen,IMAGE_BTN15);
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN3);
				SDL_UpdateRect(screen,0,0,0,0);
				SDL_Delay(1000);
				click=0;
			}
			if (click==3)
			{
				afficher_imageBTN(screen,IMAGE_BTN9);
				afficher_imageBTN(screen,IMAGE_BTN15);
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN2);
				boucle=0;
			}
			if (click==4)
			{
				afficher_imageBTN(screen,IMAGE_BTN17);
				afficher_imageBTN(screen,IMAGE_BTN1);
				afficher_imageBTN(screen,IMAGE_BTN2);
				afficher_imageBTN(screen,IMAGE_BTN3);
			}
		}

		if(niveau==2)
		{
			afficher_imageBMP(screen,BACKOP);
			if(detect1==1)
				{
					afficher_imageBTN(screen,IMAGE_BTN10);//retour
				}
			if(detect1==2)
				{
					afficher_imageBTN(screen,IMAGE_BTN11);//augmentation son
				}
			if(detect1==3)
				{
					afficher_imageBTN(screen,IMAGE_BTN12);//diminution son
				}
			if(detect1==4)
				{
					afficher_imageBTN(screen,IMAGE_BTN14);//full screen
					SDL_UpdateRect(screen,0,0,0,0);
					SDL_Delay(2000);
				}
			if(detect1==5)
				{
					afficher_imageBTN(screen,IMAGE_BTN13);//normal screen
					SDL_UpdateRect(screen,0,0,0,0);
					SDL_Delay(2000);
				}
		}
		if(niveau==3)
		{
		      	t_prev=SDL_GetTicks();
			if (stage==1)
			{
				afficher_background(screen,BACKPLAY);
                                afficher_imageBTN(screen,COIN);
                                afficher_coin(&Coin, screen);                                
				afficherPerso(p,screen);
				if (choixplayer==1)
				{
					afficherPerso(p,screen);
				}
				else if (choixplayer==2)
				{
					afficherPerso(p2,screen);
				}
				afficherEnnemi(E,screen);
				SDL_BlitSurface(text2,NULL,screen,&(p.position_textee));
				SDL_BlitSurface(text1,NULL,screen,&(p.position_texte));
				SDL_BlitSurface(number, NULL, screen,&p.position_number);
                                SDL_BlitSurface(m1.imgbonhomme, NULL, screen, &m1.positionminijoueur);
				afficherminimap(m1,screen);
			        MAJMinimap(p.position,&m1,camera5,redimensionnement);		
  			        afficher(mat,screen);
      			        animer(mat); 
                                afficher_temps(&t, screen); 
 			}
			else if (stage==2)
			{
				afficher_background(screen,BACKPLAY2);
                                afficher_imageBTN(screen,COIN);
                                afficher_coin(&Coin, screen);         
				if (choixplayer==1)
				{
					afficherPerso(p,screen);
				}
				else if (choixplayer==2)
				{
					afficherPerso(p2,screen);
				}
				afficherEnnemi(E,screen);
				SDL_BlitSurface(text2,NULL,screen,&(p.position_textee));
				SDL_BlitSurface(text1,NULL,screen,&(p.position_texte));
				SDL_BlitSurface(number, NULL, screen,&p.position_number);
				afficherminimap(m2,screen);
			        MAJMinimap(p.position,&m2,camera5,redimensionnement);	
  			        afficher(mat,screen);
      			        animer(mat); 
                                afficher_temps(&t, screen);
			}
			else if (stage==3)
			{
				afficher_background(screen,BACKPLAY3);
                                afficher_imageBTN(screen,COIN);
                                afficher_coin(&Coin, screen);         
				if (choixplayer==1)
				{
					afficherPerso(p,screen);
				}
				else if (choixplayer==2)
				{
					afficherPerso(p2,screen);
				}
				afficherEnnemi(E,screen);
				SDL_BlitSurface(text2,NULL,screen,&(p.position_textee));
				SDL_BlitSurface(text1,NULL,screen,&(p.position_texte));
				SDL_BlitSurface(number, NULL, screen,&p.position_number);
				afficherminimap(m3,screen);
			        MAJMinimap(p.position,&m3,camera5,redimensionnement);			
  			        afficher(mat,screen);
      			        animer(mat); 
                                afficher_temps(&t, screen);
			}
			
		}
		if (niveau==4)
		{
			if (e.etat==0)
			{
				afficherEnigmeIMAGE(e,screen);
				afficher_temp(&te, screen);
				afficher_imageBMP(screen,TEEMO);
			}
			
			else if (e.etat==1)
			{
				confettiAnimation(screen);
				SDL_Delay(100);
				zoomGOOD(screen,"good.png");
				SDL_Delay(1000);
				SDL_FillRect(screen, NULL,0);
				SDL_Flip(screen);
				e.etat=0;
				BE=0;
				niveau=3;
				stage=2;
			}
			else if (e.etat==-1)
			{
				zoomHARDLUCK(screen,"hardluck.png");
				SDL_Delay(1000);
				SDL_FillRect(screen, NULL,0);
				SDL_Flip(screen);
				e.etat=0;
				BE=0;
				niveau=3;
				stage=2;
			}
		}
		if (niveau==5)
		{
			//Display_Enigme(ET, screen);
			if (TEST==1)
			{
				BE=0;
			 	niveau=3;
				stage=3;
			}
			else if (TEST==0)
			{
				BE=0;
				stage=3;
			 	niveau=3;
			}
		}
		if (niveau==6)
		{
			afficher_imageBMP(screen,INPUT);
			if(detect2==1)
			{
				afficher_imageBTN(screen,IMAGE_BTN19);//c
			}
			else if (detect2==2)
			{
				afficher_imageBTN(screen,IMAGE_BTN20);//k
			}
			else if(detect2==3)
			{
				afficher_imageBTN(screen,IMAGE_BTN21);//m
			}
			else if(detect2==4)
			{
				afficher_imageBTN(screen,IMAGE_BTN10);//retour
			}
			else if (detect2==5)
			{
				afficher_imageBTN(screen,IMAGE_BTN18);//start
			}
		}
		
		//SDL_Flip(screen);
			while(SDL_PollEvent(&event))
		{
			switch(event.type)
			{
				case SDL_MOUSEMOTION:
				
				if(niveau==1)
				{
					if ((event.motion.y<=250 && event.motion.y>=200)&&(event.motion.x<=1000 && event.motion.x>=570))//play
					{
						Mix_PlayChannel(-1,muse,0);
						detect=1;
					}
					else if ((event.motion.y<=485 && event.motion.y>=454)&&(event.motion.x<=1000 && event.motion.x>=570))//option
					{
						Mix_PlayChannel(-1,muse,0);
						detect=2;
					}
					else if ((event.motion.y<=630 && event.motion.y>=580)&&(event.motion.x<=1000 && event.motion.x>=570))//quit
					{
						Mix_PlayChannel(-1,muse,0);
						detect=3;
					}
					else if ((event.motion.y<=395 && event.motion.y>=326)&&(event.motion.x<=1000 && event.motion.x>=570))//load
					{
						Mix_PlayChannel(-1,muse,0);
						detect=4;
					}
					else 
					{
						detect=0;
					}
				}
				if(niveau==2)
				{
					if ((event.motion.y<=120 && event.motion.y>=50)&&(event.motion.x<=100 && event.motion.x>=50))//retour
					{
						Mix_PlayChannel(-1,muse,0);
						detect1=1;
					}
					else if ((event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=500 && event.motion.x>=450))//augmentation son
					{
						Mix_PlayChannel(-1,muse,0);
						detect1=2;
					}
					else if ((event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=200 && event.motion.x>=100))//diminution son
					{
						Mix_PlayChannel(-1,muse,0);
						detect1=3;
					}
					else
					{
						detect1=0;
					}
				}
				if(niveau==6)
				{
					if ((event.motion.y<=120 && event.motion.y>=50)&&(event.motion.x<=100 && event.motion.x>=50))//retour
					{
						Mix_PlayChannel(-1,muse,0);
						detect2=4;
					}
					else if ((event.motion.y<=630 && event.motion.y>=580)&&(event.motion.x<=1000 && event.motion.x>=570))//quit
					{
						Mix_PlayChannel(-1,muse,0);
						detect2=5;
					}
					else
					{
						detect2=0;
					}
				}
				break;
				case SDL_MOUSEBUTTONDOWN:
				if(niveau==1)
				{
				if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=250 && event.motion.y>=200)&&(event.motion.x<=1000 && event.motion.x>=570))//play
				{
					Mix_PlayChannel(-1,mus,0);
					niveau=6;
					click=1;
				}
				else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=630 && event.motion.y>=580)&&(event.motion.x<=1000 && event.motion.x>=570))//quit
				{
					Mix_PlayChannel(-1,mus,0);
					click=3;
				}
				else if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=485 && event.motion.y>=454)&&(event.motion.x<=1000 && event.motion.x>=570))//option
				{
					Mix_PlayChannel(-1,mus,0);
					click=2;
					niveau=2;
				}
				else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=600 && event.motion.y>=500)&&(event.motion.x<=1000 && event.motion.x>=570))//load
				{
					Mix_PlayChannel(-1,mus,0);
					click=4;
				}
				else 
				{
					click=0;
				}
				}
				if(niveau==2)//menu option
				{
				if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=120 && event.motion.y>=50)&&(event.motion.x<=100 && event.motion.x>=50))//retour
				{
					Mix_PlayChannel(-1,mus,0);
					niveau=1;
				}
				else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=500 && event.motion.x>=450))//musicup
				{
					Mix_PlayChannel(-1,mus,0);
					volume+=50;
					setMusicVolume(volume);
		
				}
				else if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=200 && event.motion.x>=100))//musicdown
				{
					Mix_PlayChannel(-1,mus,0);
					volume-=50;
					setMusicVolume(volume);
		
				}
				else if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=420 && event.motion.x>=370))//normal
				{
					detect1=4;
					Mix_PlayChannel(-1,mus,0);
					SetNorm(screen,&Mode);					
				}
				else if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=420 && event.motion.x>=370))//full
				{
					detect1=5;
					Mix_PlayChannel(-1,mus,0);
					SetFull(screen,&Mode);	
				}
				}	
				if(niveau==6)//menu INPUT
				{
				if ((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=120 && event.motion.y>=50)&&(event.motion.x<=100 && event.motion.x>=50))//retour
				{
					Mix_PlayChannel(-1,mus,0);
					niveau=1;
				}
				/*else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=630 && event.motion.y>=580)&&(event.motion.x<=1000 && event.motion.x>=570))//p1 boy
				{
					Mix_PlayChannel(-1,mus,0);
					choixplayer=1;	
				}
				else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=510 && event.motion.y>=410)&&(event.motion.x<=500 && event.motion.x>=450))//p2 girl
				{
					Mix_PlayChannel(-1,mus,0);
					choixplayer=2;	
				}*/
				else if((event.button.button==SDL_BUTTON_LEFT)&&(event.motion.y<=630 && event.motion.y>=580)&&(event.motion.x<=1000 && event.motion.x>=570))//start 
				{
					Mix_PlayChannel(-1,mus,0);
					niveau=3;
					stage=1;	
				}
				}
				if (choixtype==3)//mouse
				{
					if ((niveau==3)&&(choixplayer==1))///////////////////////////////////////////////
					{
						if (event.button.button == SDL_BUTTON_LEFT) 
						{
							 p.direction=1;
						    	p.acceleration+=0.005;
						}
						 if (event.button.button == SDL_BUTTON_RIGHT) 
						{
							 p.direction=0;
						    	p.acceleration+=0.005;
						 }
				
					}
					if ((niveau==3)&&(choixplayer==2))///////////////////////////////////////////////
					{
						if (event.button.button == SDL_BUTTON_LEFT) 
						{
							p2.direction=1;
						    	p2.acceleration+=0.005;
						}
						 if (event.button.button == SDL_BUTTON_RIGHT) 
						{
							p2.direction=0;
						    	p2.acceleration+=0.005;
						 }
				
					}
				}					
				break;
				case SDL_MOUSEBUTTONUP:///////////////////////////////////////////
				if (choixtype==3)//mouse
				{
					if ((niveau==3)&&(choixplayer==1))
					{
					    if (event.button.button == SDL_BUTTON_LEFT) 
						{
						 	p.direction=3;
					    		p.vitesse=0.5;
					    		p.acceleration=0;
					    	}
						 else if (event.button.button == SDL_BUTTON_RIGHT) 
						{
						 	p.direction=2; 
					     		p.vitesse=0.5;
					     		p.acceleration=0;
					    	}
					}
					if ((niveau==3)&&(choixplayer==2))
					{
					    if (event.button.button == SDL_BUTTON_LEFT) 
						{
						 	p2.direction=3;
					    		p2.vitesse=0.5;
					    		p2.acceleration=0;
					    	}
						 else if (event.button.button == SDL_BUTTON_RIGHT) 
						{
						 	p2.direction=2; 
					     		p2.vitesse=0.5;
					     		p2.acceleration=0;
					    	}
					}
				}
				 break;
				case SDL_QUIT:////////////////////////////////////////////////////////////////
				f=fopen("score.txt","a");
                                    fprintf(f,"%d\n",p.score);
                                    fclose(f);
					boucle=0;
				break;
				case SDL_KEYDOWN:
				if (event.key.keysym.sym==SDLK_ESCAPE)
				{
					boucle=0;
				}
				
			       if (niveau==6)////////////menu INPUT
				{
					if (event.key.keysym.sym==SDLK_s)
					{
						niveau=3;
						stage=1;
					}
				       else if (event.key.keysym.sym==SDLK_b)
					{
						initPerso(&p);
						choixplayer=1;	
					}
					else if (event.key.keysym.sym==SDLK_g)
					{
						initPerso2(&p2);
						choixplayer=2;	
					}
					else if (event.key.keysym.sym==SDLK_c)
					{
						choixtype=1;
						detect2=1;
					}
				       else if (event.key.keysym.sym==SDLK_k)
					{
						choixtype=2;
						detect2=2;
					}
					else if (event.key.keysym.sym==SDLK_q)
					{
						choixtype=3;
						detect2=3;
					}
				}
			        if(niveau==1)////////////menu principale
				{
					if (event.key.keysym.sym==SDLK_p)
					{
						niveau=6;
					}
		                 
		               		else if ((detect==0)&&(event.key.keysym.sym==SDLK_DOWN))
					{
						detect=1;
		                      		Mix_PlayChannel(-1,muse,0);
					}
		               		else if ((detect==1)&&(event.key.keysym.sym==SDLK_DOWN))
					{
				                 detect=4;
				                 Mix_PlayChannel(-1,muse,0);
		                        }

		               		else if ((detect==4)&&(event.key.keysym.sym==SDLK_DOWN))
					{
		                        	 detect=2;
		                 		Mix_PlayChannel(-1,muse,0);
		                        }
		              		 else if ((detect==3)&&(event.key.keysym.sym==SDLK_DOWN))
					{
				                 detect=1;
				                 Mix_PlayChannel(-1,muse,0);
		                        }
					 else if ((detect==2)&&(event.key.keysym.sym==SDLK_DOWN))
					{
				                 detect=3;
				                 Mix_PlayChannel(-1,muse,0);
		                        }
		              		 else if ((detect==3)&&(event.key.keysym.sym==SDLK_UP))
					{
						detect=2;
		                    		Mix_PlayChannel(-1,muse,0);
					}
					else if ((detect==4)&&(event.key.keysym.sym==SDLK_UP))
					{
						detect=1;
		                    		Mix_PlayChannel(-1,muse,0);
					}
		                	else if ((detect==2)&&(event.key.keysym.sym==SDLK_UP))
					{
						detect=4;
		                      		 Mix_PlayChannel(-1,muse,0);
					}
		                	else if ((detect==1)&&(event.key.keysym.sym==SDLK_UP))
					{
						detect=3;
		                                Mix_PlayChannel(-1,muse,0);
					}
			        	else if((detect==1)&&(event.key.keysym.sym==SDLK_KP_ENTER))
				        {
				          	niveau=6;
				        }
					else  if((detect==2)&&(event.key.keysym.sym==SDLK_KP_ENTER))
				        {
				          	niveau=2;
				        }
					/*else  if((detect==4)&&(event.key.keysym.sym==SDLK_KP_ENTER))
				        {
				          	niveau=2;
				        }*/
			       		 else  if((detect==3)&&(event.key.keysym.sym==SDLK_KP_ENTER))
				        {
				         	boucle=0; 
				        }
                              
					else if (event.key.keysym.sym==SDLK_o)
					{
						niveau=2;
					}
				}
				else if(niveau==2)//////////////////menu option
				{
					 if (event.key.keysym.sym==SDLK_LEFT)
					{
						niveau=1;
					}
					else if (event.key.keysym.sym==SDLK_UP)
					{
						volume+=50;
						setMusicVolume(volume);
					}
					else if (event.key.keysym.sym==SDLK_DOWN)
					{
						volume-=50;
						setMusicVolume(volume);
					}
					else if (event.key.keysym.sym==SDLK_f)
					{
						SetFull(screen,&Mode);
					}
					else if (event.key.keysym.sym==SDLK_n)
					{
						SetNorm(screen,&Mode);
					}
				}
				
				else if ((niveau==4)&&(rep==-1))//enigme
				{
					if (event.key.keysym.sym==SDLK_a)//a changer
					{
						rep=1;
					}
					else if (event.key.keysym.sym==SDLK_b)
					{
						rep=2;
					}
					else if (event.key.keysym.sym==SDLK_c)
					{
						rep=3;
					}
				}
				else if (niveau==5)///////////////enig texte
				{
	       				if (event.key.keysym.sym == SDLK_a)
	      				  {
						 ET->image_courrante = 1;				
			  			 printf("a key (%d) pressed\n", event.key.keysym.sym);
			    			 TEST=VerifierEnigme(ET, screen);
		
	       				 }
					 else if (event.key.keysym.sym == SDLK_b)
					{
						 ET->image_courrante = 2;
			   			 printf("b key (%d) pressed\n", event.key.keysym.sym);
			   			 TEST=VerifierEnigme(ET, screen);
		
				 	}
					else if (event.key.keysym.sym == SDLK_c)
	       				 {
						ET->image_courrante=3;
			    			printf("c key (%d) pressed\n", event.key.keysym.sym);
			   			TEST=VerifierEnigme(ET, screen);
				
	       				 }
				}
			     ///////////////////////////////////////
                              	else if(niveau==3)
  				{
  				
  				        if(event.key.keysym.sym==SDLK_h)
                                        {
                
                                            afficher_texte1(screen,txte1);
                                            afficher_texte2(screen,txte2,tab[0]);
                                            afficher_texte3(screen,txte3,tab[1]);
                                            afficher_texte4(screen,txte4,tab[2]);
                                            SDL_UpdateRect(screen,0,0,0,0);
                                            
                                        }
					if(choixplayer==1)
					{
					if (event.key.keysym.sym==SDLK_RIGHT)/////////////////////////////right
                   		        {
                   			  if(p.position.x>=750 && BACKPLAY.camera.x<=6950)
					  {
                   			        p.direction=0;
					        p.acceleration+=0.01;
                   			        if (stage==1)
						{
		           			   scrolling(&BACKPLAY,0);////////////////////////////////////////////////////
						   scrolling(&Masque1,0);////////////////////////////
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,0);
 						   scrolling(&Masque2,0);

						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,0);
 						   scrolling(&Masque3,0);
						}
                   			   }
                   			}	
					if (event.key.keysym.sym==SDLK_LEFT)//////////////////////////////left
					{
					    if(p.position.x>=750 && BACKPLAY.camera.x>=50)
					    {
					         p.direction=1;
						 p.acceleration+=0.01;
					        if (stage==1)
						{
		           			   scrolling(&BACKPLAY,1);////////////////////////////////////////////////////
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,1);
						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,1);
						}
					    }
					}
					if(event.key.keysym.sym ==SDLK_UP && p.up==0)//////////////////saut verticale
					{
					        posinit=p.position.y;
					        p.up=1;
					        if (stage==1)
						{ 
		           			   scrolling(&BACKPLAY,2);////////////////////////////////////////////////////                                             
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,2);
						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,2);
						}
					       Mix_PlayChannel(-1,muse3,0);
					}
                                        if(event.key.keysym.sym ==SDLK_DOWN )//////////////////saut verticale
					{
					       if (stage==1)
						{ 
			   			   scrolling(&BACKPLAY,3);////////////////////////////////////////////////////                                             
						}
						else if (stage==2)
						{
			   			   scrolling(&BACKPLAY2,3);
						}
						else if (stage==3)
						{
			   			   scrolling(&BACKPLAY3,3);
						}				    
					}
					if(event.key.keysym.sym ==SDLK_SPACE && p.up==0)///////////////saut parabolique
					{  
					    if(p.direction==2)
					    {
						    Mix_PlayChannel(-1,muse3,0);
						    posinit=p.position.y;
						    p.posRelative.x=-100;
						    p.posRelative.y=0;
						    p.px=p.position.x;
						    p.py=p.position.y;
						    p.up=3;
					           /* if (stage==1)
						    {
			   			   	scrolling(&BACKPLAY,0);////////////////////////////////////////////////////
						    }
						    else if (stage==2)
						   {
			   			   	scrolling(&BACKPLAY2,0);
						   }*/
					    }
					    if(p.direction==3)
					    {
						    Mix_PlayChannel(-1,muse3,0);
						    posinit=p.position.y;
						    p.posRelative.x=-100;
						    p.posRelative.y=0;
						    p.px=p.position.x;
						    p.py=p.position.y;
						    p.up=4;
						     /* if (stage==1)
							{
				   			   scrolling(&BACKPLAY,1);////////////////////////////////////////////////////
							}
							else if (stage==2)
							{
				   			   scrolling(&BACKPLAY2,1);
							}*/
					    }

					}
					}
					if(choixplayer==2)
					{
					if (event.key.keysym.sym==SDLK_d)/////////////////////////////right perso2
                   		        {
                   			  if(p2.position.x>=750 && BACKPLAY.camera.x<=6950)
					  {
                   			        p2.direction=0;
					        p2.acceleration+=0.01;
                   			        if (stage==1)
						{
		           			   scrolling(&BACKPLAY,0);////////////////////////////////////////////////////
						   scrolling(&Masque1,0);////////////////////////////
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,0);
 						   scrolling(&Masque2,0);

						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,0);
 						   scrolling(&Masque3,0);
						}
                   			   }
                   			}	
					if (event.key.keysym.sym==SDLK_q)//////////////////////////////left perso2
					{
					    if(p2.position.x>=750 && BACKPLAY.camera.x>=50)
					    {
					         p2.direction=1;
						 p2.acceleration+=0.01;
					        if (stage==1)
						{
		           			   scrolling(&BACKPLAY,1);////////////////////////////////////////////////////
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,1);
						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,1);
						}
					    }
					}
					if(event.key.keysym.sym ==SDLK_z && p2.up==0)//////////////////saut verticale perso2
					{
					        posinit=p2.position.y;
					        p2.up=1;
					        if (stage==1)
						{ 
		           			   scrolling(&BACKPLAY,2);////////////////////////////////////////////////////                                             
						}
						else if (stage==2)
						{
		           			   scrolling(&BACKPLAY2,2);
						}
						else if (stage==3)
						{
		           			   scrolling(&BACKPLAY3,2);
						}
					       Mix_PlayChannel(-1,muse3,0);
					}
                                        if(event.key.keysym.sym ==SDLK_DOWN )//////////////////saut verticale perso2
					{
					       if (stage==1)
						{ 
			   			   scrolling(&BACKPLAY,3);////////////////////////////////////////////////////                                             
						}
						else if (stage==2)
						{
			   			   scrolling(&BACKPLAY2,3);
						}
						else if (stage==3)
						{
			   			   scrolling(&BACKPLAY3,3);
						}				    
					}
					if(event.key.keysym.sym ==SDLK_a && p2.up==0)///////////////saut parabolique perso2
					{  
					    if(p2.direction==2)
					    {
						    Mix_PlayChannel(-1,muse3,0);
						    posinit=p2.position.y;
						    p2.posRelative.x=-100;
						    p2.posRelative.y=0;
						    p2.px=p2.position.x;
						    p2.py=p2.position.y;
						    p2.up=3;
					           /* if (stage==1)
						    {
			   			   	scrolling(&BACKPLAY,0);////////////////////////////////////////////////////
						    }
						    else if (stage==2)
						   {
			   			   	scrolling(&BACKPLAY2,0);
						   }*/
					    }
					    if(p2.direction==3)
					    {
						    Mix_PlayChannel(-1,muse3,0);
						    posinit=p2.position.y;
						    p2.posRelative.x=-100;
						    p2.posRelative.y=0;
						    p2.px=p2.position.x;
						    p2.py=p2.position.y;
						    p2.up=4;
						     /* if (stage==1)
							{
				   			   scrolling(&BACKPLAY,1);////////////////////////////////////////////////////
							}
							else if (stage==2)
							{
				   			   scrolling(&BACKPLAY2,1);
							}*/
					    }

					}
					}					
					if (event.key.keysym.sym==SDLK_ESCAPE)//////////////////////////echap
					{
					    boucle=0;
					}
					
					break;	
					case SDL_KEYUP:
					if (niveau==3)
					{
						if (event.key.keysym.sym==SDLK_RIGHT)//////////////////////////right
						{
						     p.direction=2; 
						     p.vitesse=0;
						     p.acceleration=0;
						     
						}
						if (event.key.keysym.sym==SDLK_LEFT)//////////////////////////left
						{
						    p.direction=3;
						    p.vitesse=0;
						    p.acceleration=0;
						}
						if (event.key.keysym.sym==SDLK_d)//////////////////////////right perso2
						{
						     p2.direction=2; 
						     p2.vitesse=0.5;
						     p2.acceleration=0;
						}
						if (event.key.keysym.sym==SDLK_q)//////////////////////////left perso2
						{
						    p2.direction=3;
						    p2.vitesse=0.5;
						    p2.acceleration=0;
						}
					}
					break;	
					}
				}		
			
		}
		
		/////////////////////////////////////////////////////////////////
		if((choixplayer==1)&&(niveau==3))
		{
		if (keystates[SDLK_RIGHT])// Vérification si le bouton 'right' est enfoncé
		{
			p.direction=0;
			p.acceleration+=0.01;
			//p.vitesse =0.25;
			
		}
		if (keystates[SDLK_LEFT])// Vérification si le bouton 'right' est enfoncé
		{
			p.direction=1;
			p.acceleration+=0.01;
			//p.vitesse =0.25;
		}
	        //////////////////////////////////////////////////////////////////////////
		if(p.up==3 || p.up==4)
		{
			if(p.posRelative.x>=-100 && p.posRelative.x<100)
			{
				SDL_Delay(15);
				saut(&p,dt,posinit);
			}
			if(p.posRelative.x==100)
				p.up=0;
		}
	        ///////////////////////////////////////////////////////////////////////////////
		if(p.up>0 && p.up<3)
		{
		    saut(&p,dt,posinit);
		}
		if(p.direction==0 || p.direction==1)
		{
                        if(p.position.x<=1350 && p.position.x>=20)
                       {
		           movePerso (&p,dt);
                       }
                       else if(BACKPLAY.camera.x>=6940)
                       {
                        if(stage==1)
                        {
                          BE=1;
                        }
                       else if((BACKPLAY2.camera.x>=6940)&&(stage==2))
                       {
                       
                          BE=2;
                        
                       }
			else if((BACKPLAY3.camera.x>=6940)&&(stage==3))
                       {
                       
                          niveau=7;
                        
                       }
                       }

			animerPerso (&p);
		}
		if(p.direction==2 || p.direction==3)
		{
			SDL_Delay(70);
			animerPerso (&p);
		}
		dt=SDL_GetTicks()-t_prev;
		}
		else if((choixplayer==2)&&(niveau==3))///////////////////////////////////////////////////////////////////////////////////perso2
		{
		if (keystates[SDLK_d])// Vérification si le bouton 'right' est enfoncé
		{
			p2.direction=0;
			p2.acceleration+=0.01;
			//p.vitesse =0.25;
			
		}
		if (keystates[SDLK_q])// Vérification si le bouton 'right' est enfoncé
		{
			p2.direction=1;
			p2.acceleration+=0.01;
			//p.vitesse =0.25;
		}
	        //////////////////////////////////////////////////////////////////////////
		if(p2.up==3 || p2.up==4)
		{
			if(p2.posRelative.x>=-100 && p2.posRelative.x<100)
			{
				SDL_Delay(15);
				saut(&p2,dt,posinit);
			}
			if(p2.posRelative.x==100)
				p2.up=0;
		}
	        ///////////////////////////////////////////////////////////////////////////////
		if(p2.up>0 && p2.up<3)
		{
		    saut(&p2,dt,posinit);
		}
		if(p2.direction==0 || p2.direction==1)
		{
                        if(p2.position.x<=1350 && p2.position.x>=20)
                       {
		           movePerso (&p2,dt);
                       }
                       else if(BACKPLAY.camera.x>=6940)
                       {
                        if(stage==1)
                        {
                          BE=1;
                        }
                       else if((BACKPLAY2.camera.x>=6940)&&(stage==2))
                       {
                       
                          BE=2;
                        
                       }
			else if((BACKPLAY3.camera.x>=6940)&&(stage==3))
                       {
                       
                          niveau=7;
                        
                       }
                       }

			animerPerso (&p2);
		}
		if(p2.direction==2 || p2.direction==3)
		{
			SDL_Delay(70);
			animerPerso (&p2);
		}
		dt=SDL_GetTicks()-t_prev;
		}
		moveEnnemi(&E);
		animerEnnemi (&E);
		/*collision=collisionBB(E,p);
						    
			//printf("%d",collision);
			    if (collision==0)
			    {
				     boucle=0;
				    //p.nb_vie--;
				    Mix_PlayChannel(-1,muse2,0);
			    }*/
			/*collision1 = collisionPP(p,&Masque1,&BACKPLAY);
			if (collision1== 1 )
		       {
			p.position.y = 450;
			p.position.x = 150;
		       }*/
			if ((niveau==3)&&(stage==1))
			{
				if (BE==1)
				{
					generer(&e,"urlsImagesEnigmes.txt");
					niveau=4;//enigme
					initialiser_temp(&te);
				}
			}
			else if ((niveau==3)&&(stage==2))
			{
				if (BE==2)
				{

					genererEnigme(&g, "questions.txt", "reponses.txt", "vraireponses.txt");
					ET = &g;
					niveau=5;//enigmetexte
				}

			}
			if ((niveau==4)&&(rep!=-1)&& ( BE==1))
		  	{
				afficher_temp(&te, screen);
				if (rep==e.reponse_juste)
				{
					e.etat=1;
					//p.score=p.score+50;
				}
				else
				{
					e.etat=-1;
				}
		  	}

			if (te.sp==20)
			{
			  te.color.r = 255; 
			    te.color.g = 0 ; 
			    te.color.b = 0 ; 
			}
			else if (te.sp==30) 
			{
				niveau=3;
				stage=2;
				//p.position.y = 450;
				//p.position.x = 150;
			}
	////////////////////////////////////////////////////////////////
			
			
		SDL_Flip(screen);
    }
    

    //fin de linput
	liberer_image(TEEMO);
	liberer_image(INPUT);
	liberer_image(IMAGE);
	liberer_image(BACKOP);
	liberer_image(BACKPLAY);
	liberer_image(BACKPLAY2);
	liberer_image(BACKPLAY3);
	liberer_image(IMAGE_BTN1);
	liberer_image(IMAGE_BTN2);
	liberer_image(IMAGE_BTN3);
	liberer_image(IMAGE_BTN4);
	liberer_image(IMAGE_BTN5);
	liberer_image(IMAGE_BTN6);
	liberer_image(IMAGE_BTN7);
	liberer_image(IMAGE_BTN8);
	liberer_image(IMAGE_BTN9);
	liberer_image(IMAGE_BTN10);
	liberer_image(IMAGE_BTN11);
	liberer_image(IMAGE_BTN12);
	liberer_image(IMAGE_BTN13);
	liberer_image(IMAGE_BTN14);
	liberer_image(IMAGE_BTN15);
	liberer_image(IMAGE_BTN16);
	liberer_image(IMAGE_BTN17);
	liberer_image(IMAGE_BTN18);
	liberer_image(IMAGE_BTN19);
	liberer_image(IMAGE_BTN20);
	liberer_image(IMAGE_BTN21);
        liberer_image(COIN);
	liberer_musique(music);
	liberer_musiquebref(mus);
	liberer_texte(txte);	
	//liberer_animation(&Backg);
	liberer_coin(&Coin);
	liberer(p,screen);
	liberer(p2,screen);
	liberer_texte1(txte1);
        liberer_texte2(txte2);
        liberer_texte3(txte3);
        liberer_texte3(txte4);
	SDL_FreeSurface(m1.imgbonhomme);
    	SDL_FreeSurface(m1.imgmin);
	SDL_FreeSurface(m2.imgbonhomme);
    	SDL_FreeSurface(m2.imgmin);
	SDL_FreeSurface(m3.imgbonhomme);
    	SDL_FreeSurface(m3.imgmin);
    	free_temps(&t);
	free_temp(&te);
	 SDL_FreeSurface(coinImg);
    	SDL_FreeSurface(maze);
//////////////////////////////////////////////////////////////////////////////gestion de vie
    if ( p.nb_vie==5)
    {
        SDL_FreeSurface(p.image_vie[5]);
    }
    else if ( p.nb_vie==4)
    {
        SDL_FreeSurface(p.image_vie[4]);
    }
    else if ( p.nb_vie==3)
    {
        SDL_FreeSurface(p.image_vie[3]);
    }
    else if ( p.nb_vie==2)
    {
        SDL_FreeSurface(p.image_vie[2]);
    }
    else if ( p.nb_vie==1)
    {
        SDL_FreeSurface(p.image_vie[1]);
    }
    else if ( p.nb_vie==0)
    {
        SDL_FreeSurface(p.image_vie[0]);
    }
    for(k=0;k<2;k++)
    {
	for(F=0;F<4;F++)
	{
		SDL_FreeSurface(E.img[k][F]);
	}
    }
	SDL_Quit();
	// TTF_Quit();
	return 0;
}
