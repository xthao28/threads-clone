import 'package:flutter/material.dart';
import 'package:threads_clone/consts.dart';

class HomeMainWidget extends StatelessWidget {
  const HomeMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shadowColor: backgroundColor,
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Image.asset(
          'assets/images/threads.png',
          width: height*0.037,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,                
                children: [
                  const CircleAvatar(
                    radius: 19,
                    backgroundColor: grey,
                  ),
                  sizeVer(6),
                  const Expanded(
                    child: VerticalDivider(
                      width: 1,
                      thickness: 2,
                      color: lightGreyColor,
                    ),
                  ),
                  sizeVer(6),
                  SizedBox(
                    width: 30,
                    child: Stack(
                      children: const [
                        Positioned(
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.blue
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor: Colors.red
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column( 
                    crossAxisAlignment: CrossAxisAlignment.start,                                   
                    children: [
                      Row(  
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,                    
                        children: [
                          const Text(
                            'Wade Warren',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),
                          ),
                          Row(                          
                            children: [
                              const Text(
                                '33m',
                                style: TextStyle(
                                  color: grey,
                                ),
                              ),
                              sizeHor(5),
                              const Icon(
                                Icons.more_horiz
                              )
                            ],
                          )
                        ],
                      ),
                      const Text(                        
                        "Let's talk about the incredible power of perseverance and how it can change your life. 🚀 ",
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 16
                        ),                        
                      ),                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            iconFile('like'),
                            iconFile('reply'),
                            iconFile('repost'),
                            iconFile('paperplane')
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            '12 replies',
                            style: TextStyle(
                              fontSize: 16,
                              color: grey
                            ),
                          ),
                          Text(
                            ' · ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: grey
                            ),
                          ),
                          Text(
                            '20 likes',
                            style: TextStyle(
                              fontSize: 16,
                              color: grey
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget iconFile(String nameFile){
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Image.asset(
        'assets/images/$nameFile.png',
        width: 22.5,
      ),
    );
  }
}