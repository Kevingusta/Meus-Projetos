import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'pagina_inicial.dart';



class TelaResultado extends StatelessWidget {
  final int pontuacao;
  final int totalPerguntas;
  final int erros;
  const TelaResultado(this.pontuacao, this.totalPerguntas, this.erros);


Widget _exibirTexto(int pontuacao){
if (pontuacao >5){
  return Text('                                Parabéns!!\n Você provou que possui um conhecimento\n           profundo do mundo do fitness.\n          Voçê acertou $pontuacao de $totalPerguntas   e errou $erros',
  style: TextStyle(fontSize: 25,fontFamily: 'Poet'),
  );
}else{
  
  return Text('Voçê precisa melhorar!!\n        acertou $pontuacao de $totalPerguntas\n            e errou $erros',
  style: TextStyle(fontSize: 25,fontFamily: 'Poet'),
  );
}
}

Widget _exibirLottie(int pontuacao){
if (pontuacao >5){
  return Lottie.asset("assets/json/menino_com_trofeu.json",width: 75,height: 75);
  
}else{
  return Lottie.asset("assets/json/emoji_chorando2.json.json",width: 75,height: 75);
}
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultado do Quiz',style: TextStyle(fontSize: 20,fontFamily: 'Queen'),),titleTextStyle: TextStyle(color: Color.fromARGB(255, 207, 196, 35)),
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
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                  Container(
                    width: 130,
                    height: 130,
                    child: _exibirLottie(pontuacao),
                  ),
                    
                       _exibirTexto(pontuacao),
                    


                    SizedBox(height:  20,),
                    
                    Stack(
                      alignment: Alignment.center,
                      children: [
                    SizedBox(
                      height: 170,
                      width: 170,
                      child: CircularProgressIndicator(
                        strokeWidth: 10,
                        value: pontuacao / 10,
                        color: Color.fromRGBO(156, 43, 179, 1),
                        backgroundColor: Color.fromRGBO(162, 132, 168, 1),
                      ),
                    ),
                    Column(
                      children: [
                      Text(
                        pontuacao.toString(),
                        style: const TextStyle(fontSize: 70,fontFamily: 'Poet'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${(pontuacao / totalPerguntas * 100).round()}%',
                        style: const TextStyle(fontSize: 20,fontFamily: 'Poet'),
                      ),
                      ],
                    ),
                  ],
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    height:50,
                    width:400,
                    child: ElevatedButton(
                      onPressed: (){
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWidget()),
               );
                    }, 
                    child: Text('Jogar Novamente',style: TextStyle(color: Color.fromRGBO(233, 204, 38, 0.992),fontFamily: 'Poet'), ),
                    style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(31, 26, 26, 0.953),
                          textStyle: TextStyle(fontSize: 35),
                          elevation: 15,
                          shadowColor: Color.fromRGBO(0, 0, 0, 1),
                          ),
                    
                      ),



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
