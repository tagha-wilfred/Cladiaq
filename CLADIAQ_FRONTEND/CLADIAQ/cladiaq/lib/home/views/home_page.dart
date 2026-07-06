import 'package:cladiaq/commons/colors.dart';
import 'package:cladiaq/commons/data/model/models.dart';
import 'package:cladiaq/commons/ui_helpers.dart';
import 'package:cladiaq/commons/widgets/buttom_navigation/cq_buttomn_nav_bar.dart';
import 'package:cladiaq/commons/widgets/cq_button.dart';
import 'package:cladiaq/commons/widgets/cq_icon_button.dart';
import 'package:cladiaq/commons/widgets/cq_text.dart';
import 'package:cladiaq/device_data/bloc/device_data_bloc.dart';
import 'package:cladiaq/device_data/bloc/device_data_state.dart';
import 'package:cladiaq/home/bloc/home_bloc.dart';
import 'package:cladiaq/home/bloc/home_bloc.dart';
import 'package:cladiaq/home/bloc/home_bloc.dart';
import 'package:cladiaq/home/dashboard/sensor_data_view.dart';
import 'package:cladiaq/home/widgets/atm_sound_widget.dart';
import 'package:cladiaq/home/widgets/cq_commands.dart';
import 'package:cladiaq/home/widgets/cq_recommendation_widget.dart';
import 'package:cladiaq/home/widgets/gas_widget.dart';
import 'package:cladiaq/home/widgets/remark.dart';
import 'package:cladiaq/home/widgets/search_bar.dart';
import 'package:cladiaq/home/widgets/summary_aqi.dart';
import 'package:cladiaq/home/widgets/temp_chart.dart';
import 'package:flutter/material.dart';
import 'package:cladiaq/commons/widgets/cq_app_bar.dart';
import 'package:cladiaq/home/widgets/bar_chart_widget.dart';
import 'package:cladiaq/home/widgets/line_chart_widget.dart';
import 'package:cladiaq/home/widgets/map_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xffF1F4FA),
            appBar: CqAppBar(
              hasNotifications: true,
              title: "Donard",
            ),
            //  AppBar(
            //   backgroundColor: Colors.transparent,
            //   title: Text("Orange, Sudanesse"),
            //   centerTitle: true,
            // ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color:
                        Color(0xffF0F9FF), // Set the body color to transparent
                  ),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: SingleChildScrollView(
                        child: state is HomeLoadingState
                            ? Center(
                                child: Container(
                                child: CircularProgressIndicator(),
                              ))
                            : state is HomeErrorState
                                ? Center(
                                    child: Container(
                                      child: Text(
                                        "Error",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  )
                                : state is HomeLoadedState
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 25,
                                            width: 350,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    CqIconButton(
                                                        disabled: state
                                                            is HomeHomeState,
                                                        icon: "SUM",
                                                        onPressedCq: () {
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  HomeButtonClickedEvent());
                                                        }),
                                                    horizontalSpaceTiny,
                                                    CqIconButton(
                                                        icon: "GAS",
                                                        disabled: state
                                                            is HomeGasState,
                                                        onPressedCq: () {
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  GasButtonClickedEvent());
                                                        }),
                                                    horizontalSpaceTiny,
                                                    CqIconButton(
                                                        disabled: state
                                                            is HomeAtmState,
                                                        icon: "ATM",
                                                        onPressedCq: () {
                                                          BlocProvider.of<
                                                                      HomeBloc>(
                                                                  context)
                                                              .add(
                                                                  AtmButtonClickedEvent());
                                                        }),
                                                    horizontalSpaceTiny,

                                                    CqIconButton(
                                                        icon: "LIVE",
                                                        onPressedCq: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SensorDataPage()));
                                                        }),
                                                    // CqIconButton(
                                                    //     icon: "assets/icons/ap.svg",
                                                    //     onPressedCq: () {}),
                                                    // CqIconButton(
                                                    //     icon: "assets/icons/LI.svg",
                                                    //     onPressedCq: () {}),
                                                    // CqIconButton(
                                                    //     icon: "assets/icons/DB.svg",
                                                    //     onPressedCq: () {}),
                                                    // CqIconButton(
                                                    //     icon: "assets/icons/PPM.svg",
                                                    //     onPressedCq: () {}),
                                                    // horizontalSpaceMedium,
                                                    // CqIconButton(
                                                    //     icon: "assets/icons/All.svg",
                                                    //     onPressedCq: () {}),
                                                    // CqIconButton(
                                                    //     disabled: false,
                                                    //     icon: "assets/icons/filt.svg",
                                                    //     onPressedCq: () {})
                                                  ],
                                                ),
                                                // Container(
                                                //     height: 10,
                                                //     width: 100,
                                                //     child: DropdownMenu(
                                                //       dropdownMenuEntries: <DropdownMenuEntry<
                                                //           String>>[
                                                //         DropdownMenuEntry(
                                                //             value: "Outdoor",
                                                //             label: "Outdoor"),
                                                //         DropdownMenuEntry(
                                                //             value: "Indoor",
                                                //             label: "Indoor"),
                                                //       ],
                                                //     )),
                                                SizedBox(
                                                  height: 24,
                                                  width: 100,
                                                  child: Stack(
                                                    children: [
                                                      CqButton(
                                                        title: "Devices",
                                                        onPressedCq: () {},
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          state is HomeHomeState
                                              ? verticalSpaceMedium
                                              : Container(),
                                          state is HomeHomeState
                                              ? CqText.heading3("My Office")
                                              : Container(),
                                          state is HomeHomeState
                                              ? verticalSpaceSmall
                                              : Container(),
                                          state is HomeHomeState
                                              ? AqiSumHome(aqIsum: state.aqiSum)
                                              : Container(),
                                          state is HomeHomeState
                                              ? verticalSpaceSmall
                                              : Container(),
                                          state is HomeHomeState
                                              ? AQIRemark(aqi: state.aqiSum.aqi)
                                              : Container(),
                                          state is HomeHomeState
                                              ? verticalSpaceSmall
                                              : Container(),
                                          state is HomeHomeState
                                              ? CqRecommendationWidget(
                                                  aqi: state.aqiSum.aqi,
                                                )
                                              : Container(),
                                          state is HomeHomeState
                                              ? verticalSpaceSmall
                                              : Container(),
                                          state is HomeHomeState
                                              ? CqCommands()
                                              : Container(),
                                          state is HomeHomeState
                                              ? verticalSpaceSmall
                                              : Container(),
                                          state is HomeAtmState
                                              ? LineChartWidget(
                                                  sensorDataList:
                                                      state.sensorDataList)
                                              : Container(),
                                          verticalSpaceSmall,
                                          state is HomeAtmState
                                              ? AtmSound(
                                                  humidity: (state
                                                              .sensorDataList
                                                              .last
                                                              .humidity ??
                                                          0)
                                                      .round(),
                                                  pressure: (state
                                                              .sensorDataList
                                                              .last
                                                              .atmPressure ??
                                                          0)
                                                      .round(),
                                                )
                                              : Container(),
                                          verticalSpaceSmall,
                                          state is HomeGasState
                                              ? SizedBox(
                                                  height: 75,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: screenWidth(
                                                                  context) *
                                                              3 /
                                                              8,
                                                          child: Container(
                                                            height: 75,
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional
                                                                      .topCenter,
                                                              children: [
                                                                const Text(
                                                                  "AQI",
                                                                  style: TextStyle(
                                                                      color:
                                                                          cqPrimaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Positioned(
                                                                  top: 2,
                                                                  child: Text(
                                                                    state.aqiSum
                                                                        .aqi
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            55,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w800,
                                                                        color: Color(
                                                                            0xff0CBC92)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      Container(
                                                        width: screenWidth(
                                                                context) *
                                                            4.3 /
                                                            8,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Color(
                                                                0xffDCFCE7)),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .all(6),
                                                              height: 15,
                                                              width: 15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xff3CD856),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            7.5),
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      "assets/icons/cq_disk.svg"),
                                                            ),
                                                            Text(
                                                              style: TextStyle(
                                                                  color:
                                                                      cqPrimaryColor),
                                                              "If you are considering moving to this area, You are safe",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          state is HomeGasState
                                              ? Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      GasWidget(
                                                        higest: 6,
                                                        gas: "NH3",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .nh3 ??
                                                            0,
                                                      ),
                                                      horizontalSpaceTiny,
                                                      GasWidget(
                                                        gas: "C02",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .co2 ??
                                                            0,
                                                        higest: 900,
                                                      ),
                                                      horizontalSpaceTiny,
                                                      GasWidget(
                                                        gas: "CO",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .co ??
                                                            0,
                                                        higest: 6,
                                                      ),
                                                      horizontalSpaceTiny,
                                                      GasWidget(
                                                        higest: 8,
                                                        gas: "COV",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .cov ??
                                                            0,
                                                      ),
                                                      horizontalSpaceTiny,
                                                      GasWidget(
                                                        gas: "C5H5",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .co ??
                                                            0,
                                                        higest: 12,
                                                      ),
                                                      horizontalSpaceTiny,
                                                      GasWidget(
                                                        gas: "O3",
                                                        value: state
                                                                .sensorDataList
                                                                .last
                                                                .o3 ??
                                                            0,
                                                        higest: 2,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          // BlocBuilder<DeviceDataBloc,
                                          //     DeviceDataState>(
                                          //   builder: (context, state3) {
                                          //     if (state is DeviceDataLoaded) {
                                          //       // final List<double> temp = state.deviceData
                                          //       //     .map((data) => data.temperature!)
                                          //       //     .toList();
                                          //       // final List<String> time = state.deviceData
                                          //       //     .map((data) => data.deviceId.toString())
                                          //       //     .toList();
                                          //       return LineChartWidget(
                                          //         sensorDataList:
                                          //             state.sensorDataList,
                                          //       );
                                          //     } else
                                          //       return Container();
                                          //   },
                                          // ),
                                          // verticalSpaceSmall,
                                          state is HomeGasState
                                              ? MapWidget()
                                              : Container(),
                                          verticalSpaceSmall,
                                          state is HomeGasState ||
                                                  state is HomeAtmState
                                              ? Container(
                                                  height: 180,
                                                  width: screenWidth(context) *
                                                      0.9,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff81CEF9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                12, 12, 12, 6),
                                                        height: 170,
                                                        width: screenWidth(
                                                                context) *
                                                            0.45,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Visit our website to find out more about us and our products.Visit our website to find out more about our products and services.",
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                            verticalSpaceTiny,
                                                            SizedBox(
                                                              width: 150,
                                                              height: 30,
                                                              child: CqButton(
                                                                title: "View",
                                                                onPressedCq:
                                                                    () {},
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: screenWidth(
                                                                context) *
                                                            0.45,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20)),
                                                          child: Image.asset(
                                                            fit: BoxFit.cover,
                                                            'assets/images/caption.png',

                                                            // /width: screenWidth(context) * .45,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      )
                                    : Container(
                                        child: Text(
                                        "Error",
                                        style: TextStyle(color: Colors.red),
                                      )),
                      ),
                    ),
                  ),
                ),
                // const Positioned(bottom: 4, left: 35, child: CqButtomnNavBar())
              ],
            ),
            bottomNavigationBar: const CqButtomnNavBar(
              page: 1,
            ),
          );
        },
      ),
    );
  }
}
