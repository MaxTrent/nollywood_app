import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nitoons/components/components.dart';
import 'package:nitoons/constants/app_colors.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/stars_component.dart';
import '../project_details/project_details.dart';
import 'filters_vm.dart';


class Filters extends ConsumerWidget {
  Filters({super.key});



  @override
  Widget build(BuildContext context, ref) {
 final viewModel = FiltersViewModel(ref);
     return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                'Clear',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.w700, color: selectColor),
              ),
            )
          ],
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
                  'Filters',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 21.h,
                ),
                Text(
                  'Gender',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 58.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.w),
                    child: buildGenderSelection(viewModel),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'Average rating',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                StarRatingButton(numberOfStars: 5, starColor: switchNotActive),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'Location',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
               AppDropdown(labelText: 'Country', value: viewModel.countryValue, items: [
                 'Nigeria',
                 'India',
                 'Ghana'
               ],
               onChanged: (value){
                viewModel.selectCountry(value);
               },),

                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'Actor lookalike',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  controller: viewModel.actorLookAlikeValue,
                  labelText: 'Actor lookalike',
                  hintText: '',
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'Endorsements',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                AppDropdown(
                    labelText: 'Endorsements',
                    value: viewModel.endorsementValue,
                    items: [
                      'Most Endorsed',
                      'Least Endorsed',
                      'Not Endorsed'
                    ],
                    onChanged: (value) {
                     viewModel.selectEndorsement(value);
                    }),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  'Monologue Category',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  children: List.generate(
                      9,
                      (index) => Padding(
                            padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
                            child: PinkTIle(text: 'Category ${index + 1}'),
                          )),
                ),
                SizedBox(
                  height: 22.h,
                ),
                Text(
                  'Skin Tone',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 24.h,
                      width: 43.w,
                      decoration: BoxDecoration(
                          color: Color(0xff8A5F3E),
                          borderRadius: BorderRadius.circular(4.r)),
                    ),
                    Row(
                      children: [
                        Text(
                          'Change',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.7)),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        SvgPicture.asset(Assets.svgs.repeat),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Distance',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      viewModel.distanceValueKm,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 6.h,
                    trackShape: CustomTrackShape(),
                    thumbShape: CustomSliderThumbShape(),
                  ),
                  child: Slider(
                    value: viewModel.distanceSliderValue,
                    onChanged: (value) {
                      viewModel.toggleDistance(value);
                    },
                    min: 0.0,
                    max: 100.0,
                    // divisions: 10,
                    activeColor: selectColor,
                    inactiveColor: borderColor,
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Playable Age',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      viewModel.playableAgeValues,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 6.h,
                    rangeTrackShape: CustomRangeTrackShape(),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                      min: 0.0,
                      max: 100.0,
                      values: viewModel.playableAgeSliderValues,
                      onChanged: (newValues) {
                        viewModel.togglePlayableAge(newValues);
                      },
                      activeColor: selectColor,
                      inactiveColor: borderColor

                      // divisions: ,
                      ),
                ),
                SizedBox(
                  height: 32.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Height',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(viewModel.heightValues,
                       style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noOverlay,
                    trackHeight: 6.h,
                    rangeTrackShape: CustomRangeTrackShape(),
                    rangeThumbShape: CircleThumbShape(),
                  ),
                  child: RangeSlider(
                      values: viewModel.heightSliderValues,
                      onChanged: (newValues) {
                        viewModel.toggleHeightValue(newValues);
                      },
                      min: 5,
                      max: 6.3333,
                      // divisions: 19,
                      activeColor: selectColor,
                      inactiveColor: borderColor),
                ),
                SizedBox(
                  height: 78.h,
                ),
                AppButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ProjectDetails())),
                    width: double.infinity,
                    text: 'Apply Filter',
                    backgroundColor: Colors.black,
                    textColor: Colors.white),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildGenderSelection(FiltersViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            viewModel.selectGender(1);
          },
          child: GenderTile(
            text: 'Female',
            index: 1,
            viewModel: viewModel,
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.selectGender(2);
          },
          child: GenderTile(
            text: 'Male',
            index: 2,
            viewModel: viewModel,
          ),
        ),
        GestureDetector(
          onTap: () {
            viewModel.selectGender(3);
          },
          child: GenderTile(text: 'Both', index: 3, viewModel: viewModel,),
        ),
      ],
    );
  }
}

class AppDropdown extends StatelessWidget {
  AppDropdown({
    this.onChanged,
    required this.labelText,
    required this.value,
    required this.items,
    super.key,
  });

  Function(String?)? onChanged;
  String value;
  String labelText;
  List<String> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 67.h,
        child: DropdownButtonFormField(
          isDense: true,
          style: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(fontWeight: FontWeight.w400),
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            hintText: '',
            labelText: labelText,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xff7C7C7C),
            ),
            hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w400, color: Color(0xffE8E6EA)),
            labelStyle: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.w400),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xff7C7C7C),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xff7C7C7C),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: Color(0xff7C7C7C),
                )),
          ),
          onChanged: onChanged,
          value: value,
          icon: null,
          iconSize: 0,
          borderRadius: BorderRadius.circular(10.r),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                    color: Colors.white,
                    child: Text(value,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontWeight: FontWeight.w400))),
              ),
            );
          }).toList(),

        ));
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomRangeTrackShape extends RoundedRectRangeSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class CustomSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;

  CustomSliderThumbShape({
    this.thumbRadius = 20.0, // Default thumb radius
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = selectColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Paint shadowPaint = Paint()
      ..color = selectColor.withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);

    canvas
      ..drawCircle(center.translate(0, 3), 21.r, shadowPaint)
      ..drawCircle(center, thumbRadius.r, paint)
      ..drawCircle(center, thumbRadius.r, borderPaint);
  }
}

class CircleThumbShape extends RangeSliderThumbShape {
  const CircleThumbShape({this.thumbRadius = 20});

  final double thumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required SliderThemeData sliderTheme,
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = selectColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final Paint shadowPaint = Paint()
      ..color = selectColor.withOpacity(0.3) // Adjust opacity as needed
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);

    canvas
      ..drawCircle(center.translate(0, 3), 21.r, shadowPaint)
      ..drawCircle(center, thumbRadius.r, fillPaint)
      ..drawCircle(center, thumbRadius.r, borderPaint);
  }
}

class GenderTile extends ConsumerWidget {
  GenderTile({
    required this.text,
    required this.index,
    required this.viewModel,
    super.key,
  });

  String text;
  int index;
  FiltersViewModel viewModel;

  @override
  Widget build(BuildContext context, ref) {

    return Container(
      height: double.infinity,
      width: 100.w,
      decoration: BoxDecoration(
          color: viewModel.isGenderSelected(index)
              ? selectColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r)),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: viewModel.isGenderSelected(index)
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }
}
