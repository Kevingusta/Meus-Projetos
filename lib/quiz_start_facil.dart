import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'resultado.dart';
import 'dart:async';

class QuizStartFacil extends StatefulWidget {
  @override
  _TelaQuizState createState() => _TelaQuizState();
}

class _TelaQuizState extends State<QuizStartFacil> {
  int erros = 0;
  int _perguntaAtual = 0;
  int _pontuacao = 0;
  Timer? _timer;
  int _tempoRestante = 10;

  void initState() {
    super.initState();
    _startTimer();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_tempoRestante > 0) {
        setState(() {
          _tempoRestante--;
        });
      } else {
        _timer?.cancel();
        _proximaPergunta();
      }
    });
  }

  void _proximaPergunta() {
    if (_perguntaAtual < _perguntasfacil.length - 1) {
      setState(() {
        _perguntaAtual++;
        _tempoRestante = 10;
        _startTimer();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TelaResultado(_pontuacao, _perguntasfacil.length, erros),
        ),
      );
    }
  }

  final List<Pergunta> _perguntasfacil = [
    Pergunta(
      pergunta: '1 - Qual método de treinamento envolve levantar pesos progressivamente mais pesados ao longo do tempo?',
      respostas: ['Treino em circuito', 'Superconjuntos', 'Conjuntos decrescentes', 'Sobrecarga progressiva'],
      respostaCorreta: 'Superconjuntos',
      imagemPath: 'assets/imagens/esteira.png',
    ),
    Pergunta(
      pergunta:
          '2 - Qual macronutriente é essencial para o crescimento e reparo muscular?',
      respostas: ['Carboidratos', 'Gorduras', 'Proteína', 'Todas as opções'],
      respostaCorreta: 'Proteína',
      imagemPath: 'assets/imagens/nutrientes.png',
    ),
    Pergunta(
      pergunta: '3 - Qual é a competição de fisiculturismo mais prestigiada do mundo?',
      respostas: ['Mr. Olympia', 'Arnold Classic', 'Sheru Classic', 'Campeonatos Nacionais de Fisiculturismo'],
      respostaCorreta: 'Mr. Olympia',
      imagemPath: 'assets/imagens/trofeu_olimpia.png',
    ),
    Pergunta(
      pergunta: '4 - Qual é o processo pelo qual as fibras musculares aumentam de tamanho?',
      respostas: [
        'Sarcopenia',
        'Hipertrofia',
        'Atrofia',
        'Miogênese'
      ],
      respostaCorreta: 'Hipertrofia',
      imagemPath: 'assets/imagens/supino.png',
    ),
    Pergunta(
      pergunta: '5 - Qual hormônio desempenha um papel crucial no crescimento e desenvolvimento muscular?',
      respostas: [
        'Testosterona',
        'Insulina',
        'Hormônio do crescimento',
        'Todas as opções'
      ],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/anabol.png',
    ),
    Pergunta(
      pergunta: '6 - Qual fator NÃO é essencial para o crescimento muscular ideal?',
      respostas: [
        'Nutrição adequada',
        'Descanso e recuperação adequados',
        'Treino excessivo',
        'Programa de treinamento eficaz'
      ],
      respostaCorreta: 'Treino excessivo',
      imagemPath: 'assets/imagens/barra.png',
    ),
    Pergunta(
      pergunta: '7 - Que papel a genética desempenha na determinação do potencial de fisiculturismo de um indivíduo?',
      respostas: ['Muito pouco', 'Moderado', 'Significativo', 'Nulo'],
      respostaCorreta: 'Significativo',
      imagemPath: 'assets/imagens/ramon-dino.png',
    ),
    Pergunta(
      pergunta: '8 - Quais são os sinais e sintomas do overtraining?',
      respostas: ['Aumento da energia e motivação', 'Dor muscular e fadiga consistentes', 'Melhoria do desempenho e recuperação', 'Diminuição do apetite e da qualidade do sono'],
      respostaCorreta: 'Dor muscular e fadiga consistentes',
      imagemPath: 'assets/imagens/overtraing.png',
    ),
    Pergunta(
      pergunta: '9 - Qual exercício composto é o mias ideal para trabalhar diversos grupos musculares ao mesmo tempo?',
      respostas: ['Agachamento', 'Supino reto', 'Remada curvada', 'Flexões de braço'],
      respostaCorreta: 'Agachamento',
      imagemPath: 'assets/imagens/ledpress.png',
    ),
    Pergunta(
      pergunta: '10 - Qual alimento é considerado uma boa fonte de proteína vegetal?',
      respostas: ['Carne bovina', 'Ovos', 'Feijão', 'Salmão'],
      respostaCorreta: 'Feijão',
      imagemPath: 'assets/imagens/protein.png',
    ),
  ];

  void _responderPergunta(String resposta) {
    if (_perguntasfacil[_perguntaAtual].respostaCorreta == resposta) {
      setState(() {
        _pontuacao++;
        print('acertou');
      });
    } else {
      erros++;
      print('errou');
    }

    if (_perguntaAtual < _perguntasfacil.length - 1) {
      setState(() {
        _timer?.cancel();
        _tempoRestante = 10;
        _startTimer();
        _perguntaAtual++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaResultado(_pontuacao, _perguntasfacil.length, erros)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Gym',
          style: TextStyle(color: Color.fromARGB(255, 207, 196, 35),fontFamily: 'Queen'
          ),
        ),
        backgroundColor: Color.fromARGB(255, 79, 79, 79),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(212, 185, 28, 1),
                    Color.fromARGB(255, 180, 180, 180),
                    Color.fromARGB(255, 5, 5, 5),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Pergunta ${_perguntaAtual + 1} de 10',style: TextStyle(fontFamily: 'Poet'),),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            strokeWidth: 7,
                            value: _tempoRestante / 10,
                            color: Color.fromRGBO(156, 43, 179, 1),
                            backgroundColor: Color.fromRGBO(162, 132, 168, 1),
                          ),
                        ),
                        Column(
                          children: [
                            Text('$_tempoRestante',style:TextStyle(fontFamily: 'Poet') ,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    
                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          _perguntasfacil[_perguntaAtual].imagemPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                        _perguntasfacil[_perguntaAtual].pergunta,
                      style: TextStyle(fontSize: 20,fontFamily: 'Poet'),
                    ),
                    SizedBox(height: 50),
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasfacil[_perguntaAtual].respostas[0]);
                            },
                            child: Text(
                                _perguntasfacil[_perguntaAtual].respostas[0],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                                style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          
                      
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasfacil[_perguntaAtual].respostas[1]);
                            },
                            child: Text(
                                _perguntasfacil[_perguntaAtual].respostas[1],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                                   style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          
                      
                          
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasfacil[_perguntaAtual].respostas[2]);
                            },
                            child: Text(
                                _perguntasfacil[_perguntaAtual].respostas[2],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasfacil[_perguntaAtual].respostas[3]);
                            },
                            child: Text(
                                _perguntasfacil[_perguntaAtual].respostas[3],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pergunta {
  final String pergunta;
  final List<String> respostas;
  final String respostaCorreta;
  final String imagemPath;

  Pergunta({
    required this.pergunta,
    required this.respostas,
    required this.respostaCorreta,
    required this.imagemPath,
  });
}
