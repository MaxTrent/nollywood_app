
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/UI%20Actor/record_monologue/record_monologue.dart';
import 'package:nitoons/components/components.dart';

import '../gen/assets.gen.dart';

class TopRecommended extends StatelessWidget {
  const TopRecommended({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.svgs.back,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 24.h,
            width: 24.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top recommended',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 24.h,
              ),
              GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MonologueTileDetails())),
                  child: MonologueTile(
                      title: 'The Cherry Orchard (Anton Chekhov)')),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
              MonologueTile(title: 'The Cherry Orchard (Anton Chekhov)'),
              SizedBox(
                height: 9.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MonologueTileDetails extends StatelessWidget {
  const MonologueTileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.svgs.back,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            height: 24.h,
            width: 24.w,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            // width: double.infinity,
            // height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Text(
                      'The Cherry Orchard (Anton Chekhov)',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Lopakhin: I bought it…I bought it! One moment…wait…if you would, ladies and gentlemen… My head’s going round and round, I can’t speak… (laughs). So now the cherry orchard is mine! Mine! (he gives a shout of laughter) Great God in heaven – the cherry orchard is mine! Tell me I’m drunk – I’m out of my mind – tell me it’s all an illusion…Don’t laugh at me! If my father and grandfather could rise from their graves and see it all happening –if they could see me, their Yermolay, their beaten, half-literate Yermolay, who ran barefoot in winter – if they could see this same Yermolay buying the estate…The most beautiful thing in the entire world! I have bought the estate where my father and grandfather were slaves, where they weren’t even allowed into the kitchens. I’m asleep – this is all just inside my head – a figment of the imagination. Hey, you in the band! Play away! I want to hear you! Everyone come and watch Yermolay Lopakhin set about the cherry orchard with his axe! Watch these trees come down! Weekend houses, we’ll build weekend houses, and our grandchildren and our great grandchildren will see a new life here…Music! Let’s hear the band play! Let’s have everything the way I want it. Here comes the new landlord, the owner of the cherry orchard! Lopakhin: I bought it…I bought it! One moment…wait…if you would, ladies and gentlemen… My head’s going round and round, I can’t speak… (laughs). So now the cherry orchard is mine! Mine! (he gives a shout of laughter) Great God in heaven – the cherry orchard is mine! Tell me I’m drunk – I’m out of my mind – tell me it’s all an illusion…Don’t laugh at me! If my father and grandfather could rise from their graves and see it all happening –if they could see me, their Yermolay, their beaten, half-literate Yermolay, who ran barefoot in winter – if they could see this same Yermolay buying the estate…The most beautiful thing in the entire world! I have bought the estate where my father and grandfather were slaves, where they weren’t even allowed into the kitchens. I’m asleep – this is all just inside my head – a figment of the imagination. Hey, you in the band! Play away! I want to hear you! Everyone come and watch Yermolay Lopakhin set about the cherry orchard with his axe! Watch these trees come down! Weekend houses, we’ll build weekend houses, and our grandchildren and our great grandchildren will see a new life here…Music! Let’s hear the band play! Let’s have everything the way I want it. Here comes the new landlord, the owner of the cherry orchard!',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 14.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: AppButton(
                text: 'Record your monologue',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RecordMonologue())),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding:  EdgeInsets.only(bottom: 14.h),
      //   child: AppButton(
      //     text: 'Record your monologue',
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //   ),
      // ),
    );
  }
}
