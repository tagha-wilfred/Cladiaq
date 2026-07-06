import 'package:cladiaq/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cladiaq/commons/colors.dart';

class CqButtomnNavBar extends StatefulWidget {
  final int page;
  const CqButtomnNavBar({super.key, required this.page});

  @override
  _CqButtomnNavBarState createState() => _CqButtomnNavBarState();
}

class _CqButtomnNavBarState extends State<CqButtomnNavBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Container(
          height: 50,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _BottomBarItem(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeStartEvent());
                  Navigator.of(context).pushNamed('/dashboard');
                },
                icon: SvgPicture.asset(
                  "assets/icons/cq_home.svg",
                  color: widget.page == 1 ? Colors.blue : cqMediumGreyColor,
                  height: 20,
                  width: 20,
                ),
                label: 'Home',
              ),
              _BottomBarItem(
                onTap: () {
                  Navigator.of(context).pushNamed('/news');
                },
                icon: SvgPicture.asset(
                  "assets/icons/cq_news.svg",
                  color: widget.page == 2 ? Colors.blue : cqMediumGreyColor,
                  height: 20,
                  width: 20,
                ),
                label: 'News',
              ),
              _BottomBarItem(
                onTap: () {
                  Navigator.of(context).pushNamed('/ai');
                },
                icon: SvgPicture.asset(
                  "assets/icons/cq_ai.svg",
                  color: widget.page == 3 ? Colors.blue : cqMediumGreyColor,
                  height: 20,
                  width: 20,
                ),
                label: 'AIRIFY AI',
              ),
              _BottomBarItem(
                onTap: () {
                  Navigator.of(context).pushNamed("/settings");
                },
                icon: SvgPicture.asset(
                  "assets/icons/cq_settings.svg",
                  color: widget.page == 4 ? Colors.blue : cqMediumGreyColor,
                  height: 20,
                  width: 20,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String label;
  final Widget icon;

  const _BottomBarItem({
    Key? key,
    this.onTap,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            this.icon,
            Text(
              this.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cqMediumGreyColor,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
