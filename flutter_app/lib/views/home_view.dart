import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/blocs/bloc.dart';
import 'package:flutterapp/models/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/loading.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState)
          return Container(
              color: Colors.black87,
              child: Loading(
                color: Colors.white,
                size: ScreenUtil().setHeight(10),
              ));
        else if (state is HomeSuccessState)
          return Scaffold(
            appBar: _mAppBar(state),
            body: Stack(
              children: <Widget>[
                _mBody(state),
              ],
            ),
          );
        else if (state is HomeFailureState) {
          return Container(
            color: Colors.black87,
            alignment: Alignment.center,
            child: Text("Error"),
          );
        } else {
          return Scaffold(
            appBar: _mAppBar(state),
            body: Stack(
              children: <Widget>[
                _mBody(state),
              ],
            ),
          );
        }
      },
    );
  }

  _mAppBar(HomeSuccessState state) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.black87,
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/favorites', arguments: state.favoritePeople),
          child: Container(
              margin: const EdgeInsets.all(15.0),
              child: Image.asset(
                'assets/img/ic-wish-list.png',
                height: ScreenUtil().setHeight(18),
              )),
        ),
      ],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "PERSONS",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Colors.white,
                letterSpacing: 3.5,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: ScreenUtil().setHeight(25),
            height: ScreenUtil().setHeight(25),
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(18)),
            child: Text(
              state.people.length.toString(),
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(12), color: Colors.white),
            ),
            decoration:
                BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  _mBody(HomeState state) {
    double initialBottom = 15.0;
    double backCardPosition =
        initialBottom + (state.people.length - 1) * 10 + 10;
    List<Person> allPersonal = state.people;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black87,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: state.people.length > 0
              ? Stack(
                  alignment: AlignmentDirectional.center,
                  children: allPersonal.map((person) {
                    if (allPersonal.indexOf(person) ==
                        state.people.length - 1) {
                      return _persentCard(
                        state,
                        person: person,
                        context: context,
                      );
                    } else {
                      backCardPosition = backCardPosition - 10;

                      return _nextCard(state,
                          person: person,
                          rotation: 0.0,
                          skew: 0.0,
                          context: context);
                    }
                  }).toList())
              : Text("No Event Left",
                  style: TextStyle(color: Colors.white, fontSize: 50.0)),
        ),
      ],
    );
  }

  Widget _persentCard(HomeState state, {Person person, BuildContext context}) {
    Size screenSize = MediaQuery.of(context).size;
    return Dismissible(
      key: UniqueKey(),
      crossAxisEndOffset: -0.3,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          BlocProvider.of<HomeBloc>(context)
            ..add(DismissPersonOnPressEvent(person));
        } else {
          BlocProvider.of<HomeBloc>(context)
            ..add(SavePersonOnPressEvent(person));
        }
      },
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Container(
          alignment: Alignment.center,
          width: screenSize.width * 0.9,
          height: screenSize.height / 1.7,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: _inforWidget(state, person),
        ),
      ),
    );
  }

  Widget _nextCard(HomeState state,
      {Person person, double rotation, double skew, BuildContext context}) {
    Size screenSize = MediaQuery.of(context).size;
    // Size screenSize=(500.0,200.0);
    // print("dummyCard");
    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        width: screenSize.width * 0.9,
        height: screenSize.height / 1.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: _inforWidget(state, person),
      ),
    );
  }

  _inforWidget(HomeState state, Person person) {
    String fullName = person.name.getFullName();
    String imgUrl = person.picture.large;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 27,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff9f9f9),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                alignment: Alignment.bottomCenter,
                child: Divider(
                  height: 0,
                  color: Colors.black26,
                  thickness: ScreenUtil().setWidth(1),
                ),
              ),
            ),
            Expanded(
              flex: 73,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20.0))),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(30)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(150),
                width: ScreenUtil().setHeight(150),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Colors.black26,
                        width: ScreenUtil().setWidth(1.5)),
                    color: Colors.white),
                padding: EdgeInsets.all(5),
                child: Container(
                    height: ScreenUtil().setHeight(128),
                    width: ScreenUtil().setHeight(128),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage("$imgUrl")),
                    )),
              ),
              _personTabWidget(person, state.tabIndex),
              BottomNavigationBar(
                currentIndex: state.tabIndex,
                iconSize: ScreenUtil().setHeight(32),
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.black26,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.user), title: new Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.envelope),
                      title: new Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.calendarAlt),
                      title: new Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.mapMarkedAlt),
                      title: new Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.phoneAlt),
                      title: new Text('')),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.lock), title: new Text(''))
                ],
                onTap: (index) {
                  BlocProvider.of<HomeBloc>(context)
                    ..add(SelecPersonTabOnPressEvent(index));
                },
              )
            ],
          ),
        )
      ],
    );
  }

  _personTabWidget(Person person, int tabIndex) {
    switch (tabIndex) {
      case 0:
        return AutoSizeText.rich(
          TextSpan(
              text: 'Hi, My name is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.name.getFullName()}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(38)))
              ]),
          textAlign: TextAlign.center,
        );
      case 1:
        return AutoSizeText.rich(
          TextSpan(
              text: 'My email address is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.email}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(38)))
              ]),
          maxLines: 3,
          textAlign: TextAlign.center,
        );
      case 2:
        return RichText(
          text: TextSpan(
              text: 'My Birthday is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.dob.date}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(38)))
              ]),
          textAlign: TextAlign.center,
        );
      case 3:
        return RichText(
          text: TextSpan(
              text: 'My address is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.location.street.getAddress()}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(38)))
              ]),
          textAlign: TextAlign.center,
        );
      case 4:
        return RichText(
          text: TextSpan(
              text: 'My phone number is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.phone}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(32)))
              ]),
          textAlign: TextAlign.center,
        );
      case 5:
        return RichText(
          text: TextSpan(
              text: 'My password is\n',
              style: TextStyle(
                  color: Colors.black26, fontSize: ScreenUtil().setSp(18)),
              children: [
                TextSpan(
                    text: '${person.login.password}',
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: ScreenUtil().setSp(38)))
              ]),
          textAlign: TextAlign.center,
        );
    }
  }
}
