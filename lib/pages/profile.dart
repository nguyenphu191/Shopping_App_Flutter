import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/models/User.dart';
import 'package:flutter_shopping_app/widgets/big_text.dart';
import 'package:flutter_shopping_app/data/app_data.dart' as app_data;

class Profile extends StatelessWidget {
  const Profile({super.key});
   
  @override
  Widget build(BuildContext context) {
    User user=app_data.userList[0];
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/background2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Container(
                  height: 730,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child:Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: BigText('', text: "Thông tin người dùng"),
                ) 
                ),
              Positioned(
                top:60,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Container(
                        margin: EdgeInsets.only(left: 10),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/nam_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      
                    ),
                    Container(
                      height: 200,
                      width: 230,
                      // color: const Color.fromARGB(255, 149, 24, 24),
                      margin: EdgeInsets.only(left: 40,top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        
                        children: [
                          Row(

                            children: [
                              Container(width: 200,alignment: Alignment.topLeft,padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              ),child: BigText('', text: user.username.toString())),
                              Container(child: Icon(
                              Icons.person,
                              ),)
                            ],
                          ),
                          
                          Row(
                            children: [
                              Container(width: 200,alignment: Alignment.topLeft,padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              ),child: BigText('', text: user.phone.toString())),
                              Container(child: Icon(
                              Icons.phone,
                              ),)
                            ],
                          ),

                          Row(
                            children: [
                              Container(width: 200,alignment: Alignment.topLeft,padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              ),child: BigText('', text: user.email.toString())),
                              Container(child: Icon(
                              Icons.email,
                              ),)
                            ],
                          ),

                          Row(
                            children: [
                              Container(width: 200,alignment: Alignment.topLeft,padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              ),child: BigText('', text: user.city.toString())),
                              Container(child: Icon(
                              Icons.location_city,
                              ),)
                            ],
                          ),
                          

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Positioned(
                top: 290,
                left: 20,
                right: 20,
                bottom: 10,
                child:Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  )
                  , child: Container(
                    margin: EdgeInsets.only(top: 10,left: 10),
                    
                    child: Column(children: [
                      Row(
                        children: [
                        
                        Container(width: 360,height: 40,alignment: Alignment.topLeft,padding: EdgeInsets.only(left: 5),decoration: BoxDecoration(color: const Color.fromARGB(255, 136, 126, 126),
                                borderRadius: BorderRadius.circular(10),
                                ),child: TextField()),
                                Container(child: Icon(
                                Icons.edit,
                                ),)
                      ],)
                    ],),
                  )
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
