#!/usr/bin/env python
# -*- coding: utf-8 -*-
#.n Juliano Garcia de Oliveira
#.u 9277086
import random
import numpy as np
import math as mat
import matplotlib.pyplot as plt
import ep2julian as ep2
def main():
	# Entrada de dados pelo usuário
	r = float(input("Digite o raio da circunferência: "))
	while r<=0:
		r = float(input("\nDigite o raio (deve ser maior que zero): "))
	n = int(input("\nDigite o n : "))
	while n<=0:
		n = int(input("\nDigite o n (deve ser maior que zero): "))
	cordasM1 = ep2.listaCordasM1(r,n)
	cordasM2 = ep2.listaCordasM2(r,n)
	cordasM3 = ep2.listaCordasM3(r,n)
	distribuicaoBorda(r,cordasM1)
	distribuicaoBorda(r,cordasM2)
	distribuicaoBorda(r,cordasM3)

		
	
		
			
def exibeGrafico(r,xs,ys,cores):	
	plt.figure(figsize=(28,10))
	plt.subplot(121,aspect='equal')
	plt.title("O círculo")
	#plt.axis([1,2.5*r,0,2.5*r],hold=True)
	#plt.axes().set_aspect("equal")
	ax = plt.gca()
	ax.spines['bottom'].set_position(('data',0))
	ax.spines['left'].set_position(('data',0))
	
	plt.text(1.1*r, 0.4*r, '1', ha='center', va='center',size=24, alpha=.5)
	plt.text(r/2, 1.1*r, '2', ha='center', va='center', size=24, alpha=.5)
	plt.text(-r/2, 1.1*r, '3', ha='center', va='center', size=24, alpha=.5)
	plt.text(-1.1*r, 0.4*r, '4', ha='center', va='center',size=24, alpha=.5)
	plt.text(-1.1*r, -0.4*r, '5', ha='center', va='center',size=24, alpha=.5)
	plt.text(-r/2, -1.1*r, '6', ha='center', va='center',size=24, alpha=.5)
	plt.text(r/2, -1.1*r, '7', ha='center', va='center',size=24, alpha=.5)
	plt.text(1.1*r, -0.4*r, '8', ha='center', va='center',size=24, alpha=.5)	
	plt.scatter(xs,ys,c = cores)	
	an = np.linspace(0, 2*np.pi, 100)
	if len(xs)<1000 :
		plt.plot(r*np.cos(an), r*np.sin(an),alpha=0.5)
	plt.yticks(())
	plt.xticks(())
	plt.subplot(122)
	plt.yticks(())
	plt.xticks(())
	plt.tight_layout()
	plt.show()
    


def distribuicaoBorda(r,listaCordas):
	xs = []
	ys = []
	cores = []
	for t in range(len(listaCordas)):
		xs.append(listaCordas[t][0][0])
		xs.append(listaCordas[t][1][0])	
		ys.append(listaCordas[t][0][1])
		ys.append(listaCordas[t][1][1])		
		#CALCULAR O HISTOGRAMA DA DISTRIBUIÇÃO DOS ÂNGULOS		
		cores.append(corBordas(mat.atan2(listaCordas[t][0][1],listaCordas[t][0][0])))
		cores.append(corBordas(mat.atan2(listaCordas[t][1][1],listaCordas[t][1][0])))
	exibeGrafico(r,xs,ys,cores)



#Converte pontos cartesianos para polares!
def cart2pol(listaPontos):
	listPtPol = []
	for x in range(len(listaPontos)):
		rho1 = mat.sqrt(listaPontos[x][0][0]**2 + listaPontos[x][0][1]**2)
		theta1 = mat.atan2(listaPontos[x][0][1],listaPontos[x][0][0])		
		rho2 = mat.sqrt(listaPontos[x][1][0]**2 + listaPontos[x][1][1]**2)
		theta2 = mat.atan2(listaPontos[x][1][1],listaPontos[x][1][0])
		pol1 = (rho1,theta1)
		pol2 = (rho2,theta2)
		listPtPol.append((pol1,pol2))
	return listPtPol
	
def pol2cart(listaPontos):
	listPtCart = []
	for x in range(len(listaPontos)):
		x1 = listaPontos[x][0][0]*mat.cos(listaPontos[x][0][1])
		y1 = listaPontos[x][0][0]*mat.sin(listaPontos[x][0][1])
		x2 = listaPontos[x][1][0]*mat.cos(listaPontos[x][1][1])
		y2 = listaPontos[x][1][0]*mat.sin(listaPontos[x][1][1])
		p1 = (x1,y1)
		p2 = (x2,y2)
		listPtCart.append((p1,p2))
	return listPtCart

def corBordas(angulo):
	if angulo<mat.pi/4 and angulo>=0:
		s = np.array([0.5,0,1])
	elif angulo<mat.pi/2 and angulo>=mat.pi/4:
		s = np.array([0,1,0])
	elif angulo<3*mat.pi/4 and angulo>=mat.pi/2:
		s = np.array([1,0,0])
	elif angulo<mat.pi and angulo>=3*mat.pi/4:
		s = np.array([0.2,0.4,0.8])
	elif angulo<0 and angulo>= - mat.pi/4:
		s = np.array([0.7,0.9,0.6])
	elif angulo<- mat.pi/4 and angulo>= - mat.pi/2:
		s = np.array([0.2,0.6,0.9])
	elif angulo<-mat.pi/2 and angulo>= -3*mat.pi/4:
		s = np.array([1,0.6,0.9])
	else:
		s = np.array([0.3,1,1])
	
	return s

if __name__ == '__main__':
	main()