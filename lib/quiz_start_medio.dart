import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'resultado.dart';
import 'dart:async';

class QuizStartMedio extends StatefulWidget {
  @override
  _TelaQuizState createState() => _TelaQuizState();
}

class _TelaQuizState extends State<QuizStartMedio> {
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
    if (_perguntaAtual < _perguntasmedio.length - 1) {
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
              TelaResultado(_pontuacao, _perguntasmedio.length, erros),
        ),
      );
    }
  }

  final List<Pergunta> _perguntasmedio = [
    Pergunta(
      pergunta: '1 - Qual processo metabólico é responsável pela produção de energia durante o exercício de alta intensidade?',
      respostas: ['Glicogênese', 'Glicolise anaeróbica', 'Ciclo de Krebs', 'Fosforilação oxidativa'],
      respostaCorreta: 'Glicolise anaeróbica',
      imagemPath: 'assets/imagens/quizgym_amarelo.png',
    ),
    Pergunta(
      pergunta:
          '2 - Qual técnica de treinamento envolve a realização de várias séries de um exercício até a falha muscular?',
      respostas: ['Drop sets', 'Treino de pausa-descanso', 'Treino de volume alemão', 'Todas as opções'],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/no_pain_no_gain.png',
    ),
    Pergunta( 
      pergunta: '3 - Qual suplemento pode auxiliar na recuperação muscular e na redução da dor pós-treino?',
      respostas: ['Creatina', 'Beta-alanina', 'Zinco', 'Whey Protein'],
      respostaCorreta: 'Creatina',
      imagemPath: 'assets/imagens/trofeu_olimpia.png',
    ),
    Pergunta(
      pergunta: '4 - Como o sono influencia o crescimento muscular?',
      respostas: [
        'Aumenta a produção de hormônios anabólicos',
        'Promove a reparação muscular e a síntese de proteínas',
        'Reduz o cortisol, um hormônio catabólico',
        'Todas as opções'
      ],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/no_pain_no_gain.png',
    ),
    Pergunta(
      pergunta: '5 - Qual fator NÃO contribui para o risco de lesões no fisiculturismo?',
      respostas: [
        'Técnica inadequada de levantamento de peso',
        'Fadiga muscular',
        'Aquecimento e desaquecimento insuficientes',
        'Flexibilidade adequada'
      ],
      respostaCorreta: 'Flexibilidade adequada',
      imagemPath: 'assets/imagens/no_pain_no_gain.png',
    ),
    Pergunta(
      pergunta: '6 - Como o estresse crônico pode afetar o progresso no fisiculturismo?',
      respostas: [
        'Aumenta o cortisol, um hormônio catabólico',
        'Suprime a produção de testosterona',
        'Dificulta a recuperação muscular',
        'Todas as opções'
      ],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/no_pain_no_gain.png',
    ),
    Pergunta(
      pergunta: '7 - Qual tipo de dieta é mais eficaz para definir o físico e reduzir a gordura corporal?',
      respostas: ['Dieta rica em carboidratos e baixa em proteínas', 'Dieta rica em proteínas e baixa em carboidratos', 'Dieta cetogênica', 'Dieta com ciclo de carboidratos'],
      respostaCorreta: 'Dieta rica em proteínas e baixa em carboidratos',
      imagemPath: 'assets/imagens/no_pain_no_gain.png',
    ),
    Pergunta(
      pergunta: '8 - O que causa a fadiga muscular durante o exercício?',
      respostas: ['Acúmulo de ácido láctico', 'Depleção de glicogênio', 'Microlesões nas fibras musculares', 'Todas as opções'],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/quizgym_amarelo.png',
    ),
    Pergunta(
      pergunta: '9 - Qual é o benefício do treinamento cardiovascular para musculação?',
      respostas: ['Aumenta a massa muscular', 'Melhora a saúde cardiovascular', 'Queima gordura corporal', 'Todas as opções'],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/quizgym_amarelo.png',
    ),
    Pergunta(
      pergunta: '10 - Qual nutriente é crucial para a absorção e utilização de proteínas pelo corpo?',
      respostas: ['Carboidratos', 'Gorduras', 'Vitaminas', 'Minerais'],
      respostaCorreta: 'Minerais',
      imagemPath: 'assets/imagens/quizgym_amarelo.png',
    ),
  ];

  void _responderPergunta(String resposta) {
    if (_perguntasmedio[_perguntaAtual].respostaCorreta == resposta) {
      setState(() {
        _pontuacao++;
        print('acertou');
      });
    } else {
      erros++;
      print('errou');
    }

    if (_perguntaAtual < _perguntasmedio.length - 1) {
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
                TelaResultado(_pontuacao, _perguntasmedio.length, erros)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Gym',
          style: TextStyle(color: Color.fromARGB(255, 207, 196, 35)
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
                        child: Text('Pergunta ${_perguntaAtual + 1} de 8'),
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
                            Text('$_tempoRestante'),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    
                    SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          _perguntasmedio[_perguntaAtual].imagemPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      _perguntasmedio[_perguntaAtual].pergunta,
                      style: TextStyle(fontSize: 20),
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
                                  _perguntasmedio[_perguntaAtual].respostas[0]);
                            },
                            child: Text(
                                _perguntasmedio[_perguntaAtual].respostas[0],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
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
                                  _perguntasmedio[_perguntaAtual].respostas[1]);
                            },
                            child: Text(
                                _perguntasmedio[_perguntaAtual].respostas[1],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
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
                                  _perguntasmedio[_perguntaAtual].respostas[2]);
                            },
                            child: Text(
                                _perguntasmedio[_perguntaAtual].respostas[2],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
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
                                  _perguntasmedio[_perguntaAtual].respostas[3]);
                            },
                            child: Text(
                                _perguntasmedio[_perguntaAtual].respostas[3],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),),
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
