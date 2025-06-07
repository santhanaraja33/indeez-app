import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/ui/common/app_colors.dart';
import 'package:music_app/ui/common/app_image.dart';
import 'package:music_app/ui/common/app_strings.dart';
import 'package:music_app/ui/data/bean/model/calender_model.dart';
import 'package:music_app/ui/views/rightmenu/rightmenu_view.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_viewmodel.dart';

class CalendarView extends StackedView<CalendarViewModel> {
  const CalendarView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CalendarViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      endDrawer: const RightmenuView(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: kcBlack,
        title: Image.asset(
          AppImage.appLogoGif,
          height: height_50,
          width: width_50,
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: kcBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: padding_20,
            right: padding_20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: height_20,
              ),
              buildCarousel(viewModel),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: viewModel.eventModel.map((url) {
                    int index = viewModel.eventModel.indexOf(url);
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            width: viewModel.current == index
                                ? width_10
                                : width_10,
                            height: height_10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: kcWhite,
                            )),
                        Container(
                          width:
                              viewModel.current == index ? width_10 : width_10,
                          height: height_10,
                          margin: const EdgeInsets.symmetric(
                              vertical: padding_10, horizontal: padding_5),
                          decoration: buildPaggerDecoration(
                            viewModel,
                            index,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(),
              TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: viewModel.focusedDays,
                selectedDayPredicate: (day) =>
                    isSameDay(viewModel.selectedDays, day),
                rangeStartDay: viewModel.rangeStarts,
                rangeEndDay: viewModel.rangeEnds,
                calendarFormat: viewModel.calendarFormat,
                rangeSelectionMode: viewModel.rangeSelectionMode,
                eventLoader: viewModel.getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  selectedTextStyle: GoogleFonts.lato(
                    color: kcPurple,
                  ),
                  tableBorder: TableBorder(
                      borderRadius: BorderRadius.circular(borderRadius_10)),
                  outsideDaysVisible: true,
                  defaultTextStyle: GoogleFonts.lato(
                    color: kcPurple,
                  ),
                  weekNumberTextStyle: GoogleFonts.lato(
                    color: kcPurple,
                  ),
                ),
                headerStyle: HeaderStyle(
                    leftChevronIcon: const Icon(
                      Icons.arrow_back_ios,
                      color: kcPurple,
                    ),
                    rightChevronIcon: const Icon(
                      Icons.arrow_forward_ios,
                      color: kcPurple,
                    ),
                    titleTextStyle: GoogleFonts.lato(
                      color: kcWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                onDaySelected: viewModel.onDaySelected,
                onRangeSelected: viewModel.onRangeSelected,
                onFormatChanged: (format) {
                  if (viewModel.calendarFormat != format) {
                    viewModel.calendarFormat = format;
                  }
                },
                onPageChanged: (focusedDay) {
                  viewModel.focusedDays = focusedDay;
                },
              ),
              Text(
                ksComingupnearyou,
                style: GoogleFonts.lato(
                  color: kcWhite,
                  fontSize: size_18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: height_10,
              ),
              ListView.builder(
                itemCount: viewModel.eventListModel.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: padding_10),
                    child: Column(
                      children: [
                        Container(
                          height: height_100,
                          decoration: BoxDecoration(
                            color: viewModel.eventListModel[index].eventColor,
                          ),
                        ),
                        const SizedBox(
                          height: height_5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        viewModel.eventListModel[index].time ??
                                            '',
                                        style: GoogleFonts.lato(
                                          color: kcWhite,
                                          fontSize: size_14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        viewModel.eventListModel[index]
                                                .eventName ??
                                            '',
                                        style: GoogleFonts.lato(
                                          color: kcWhite,
                                          fontSize: size_14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    viewModel
                                            .eventListModel[index].eventTitle ??
                                        '',
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    viewModel.eventListModel[index].address ??
                                        '',
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: kcLightBlack,
                                  borderRadius:
                                      BorderRadius.circular(borderRadius_30)),
                              child: Padding(
                                padding: const EdgeInsets.all(padding_10),
                                child: Text(
                                  viewModel.eventListModel[index].thisEvent ??
                                      '',
                                  style: GoogleFonts.lato(
                                    color: kcWhite,
                                    fontSize: size_14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: height_20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration buildPaggerDecoration(CalendarViewModel viewModel, int index) {
    return index == viewModel.current
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius_30),
            color: kcPurple,
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            color: viewModel.current == index ? kcWhite : kcWhite);
  }

  Widget buildCarousel(CalendarViewModel viewModel) {
    return CarouselSlider(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          viewModel.current = index;
          viewModel.rebuildUi();
        },
        viewportFraction: 1,
      ),
      items: viewModel.eventModel
          .map(
            (item) => Container(
              decoration: BoxDecoration(
                color: kcLightBlack,
                borderRadius: BorderRadius.circular(borderRadius_10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: padding_10, right: padding_10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: height_20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$ksToday:',
                                    style: GoogleFonts.lato(
                                      color: kcPurple,
                                      fontSize: size_16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: width_5,
                                  ),
                                  Text(
                                    item.time ?? '',
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: width_5,
                                  ),
                                  SizedBox(
                                    width: height_100,
                                    child: Text(
                                      item.today ?? '',
                                      style: GoogleFonts.lato(
                                        color: kcYellow,
                                        fontSize: size_16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: width_50,
                                  ),
                                  Text(
                                    '@',
                                    style: GoogleFonts.lato(
                                      color: kcWhite,
                                      fontSize: size_16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: width_5,
                                  ),
                                  SizedBox(
                                    width: width_100,
                                    child: Text(
                                      item.title ?? '',
                                      style: GoogleFonts.lato(
                                        color: kcYellow,
                                        fontSize: size_16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: width_50,
                                  ),
                                  SizedBox(
                                    width: width_100,
                                    child: Text(
                                      item.location ?? '',
                                      style: GoogleFonts.lato(
                                        color: kcWhite,
                                        fontSize: size_16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Image.network(
                          item.image ?? '',
                          fit: BoxFit.cover,
                          width: width_50,
                          height: height_50,
                          errorBuilder: (context, error, stackTrace) {
                            return Text(
                              ksImageNotFound,
                              style: GoogleFonts.lato(color: kcTextGrey),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  CalendarViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CalendarViewModel();
}
