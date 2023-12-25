import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoluntaryPracticalTrainingScreen extends StatefulWidget {
  const VoluntaryPracticalTrainingScreen({super.key});

  @override
  State<VoluntaryPracticalTrainingScreen> createState() =>
      _VoluntaryPracticalTrainingScreenState();
}

class _VoluntaryPracticalTrainingScreenState
    extends State<VoluntaryPracticalTrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 372),
        child: Stack(
          children:[
            Image.asset('assets/images/volunteer1.png',
                width: double.infinity, fit: BoxFit.fill),
            Positioned(
              right: 27,
              top: 50,
              child: CircleAvatar(
                radius: 20,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Color(0xffD9D9D9),
              ),
            )
          ]
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  'لوريم ايبسوم',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/calender.svg'),
                  SizedBox(width: 5),
                  Text(
                    '22-10-2023',
                    style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Text(
                'full description',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  fontFamily: 'Alexandria',
                  height: 2.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
