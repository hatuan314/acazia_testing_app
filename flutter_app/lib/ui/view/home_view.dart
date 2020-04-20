import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
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
  AnimationController _buttonAnimationController;

  Animation<double> rotate;
  List<Person> _allPersons = List<Person>();
  int flag = 0;

  List selectedData = [];

  void initState() {
    super.initState();

    _buttonAnimationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    rotate = Tween<double>(
      begin: -0.0,
      end: -40.0,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.ease,
      ),
    );
    rotate.addListener(() {
      setState(() {
        if (rotate.isCompleted) {
          var i = _allPersons.removeLast();
          _allPersons.insert(0, i);

          _buttonAnimationController.reset();
        }
      });
    });
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

  Future<Null> _swipeAnimation() async {
    try {
      await _buttonAnimationController.forward();
    } on TickerCanceled {}
  }

  swipeRight() {
    if (flag == 0)
      setState(() {
        flag = 1;
      });
    _swipeAnimation();
  }

  swipeLeft() {
    if (flag == 1)
      setState(() {
        flag = 0;
      });
    _swipeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(106, 94, 175, 1.0),
          appBar: _mAppBar(state.allPersons.length),
          body: _mBody(state),
        );
      },
    );
  }

  _mAppBar(int dataLength) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color.fromRGBO(106, 94, 175, 1.0),
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.all(15.0),
        child: Icon(
          Icons.equalizer,
          color: Colors.white,
          size: 30.0,
        ),
      ),
      actions: <Widget>[
        GestureDetector(
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
              dataLength.toString(),
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
        initialBottom + (state.allPersons.length - 1) * 10 + 10;
    List<Person> allPersonal = state.allPersons;
    if (state is HomeLoadingState) {
      return Container(
          color: Color.fromRGBO(106, 94, 175, 1.0),
          child: Loading(
            color: Colors.white,
            size: ScreenUtil().setHeight(10),
          ));
    } else if (state is HomeSuccessState) {
      return Container(
        color: Color.fromRGBO(106, 94, 175, 1.0),
        alignment: Alignment.center,
        child: state.allPersons.length > 0
            ? Stack(
                alignment: AlignmentDirectional.center,
                children: allPersonal.map((person) {
                  if (allPersonal.indexOf(person) ==
                      state.allPersons.length - 1) {
                    return _persentCard(state,
                        person: person,
                        rotation: rotate.value,
                        skew: rotate.value < -10 ? 0.1 : 0.0,
                        context: context,
                        flag: flag);
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
      );
    } else if (state is HomeFailureState) {
      return Center(
        child: Text("Error"),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _persentCard(HomeState state,
      {Person person,
      double rotation,
      double skew,
      BuildContext context,
      int flag}) {
    Size screenSize = MediaQuery.of(context).size;
    // print("Card");
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
      child: Transform(
        alignment: flag == 0 ? Alignment.bottomRight : Alignment.bottomLeft,
        transform: Matrix4.skewX(skew),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(
              flag == 0 ? rotation / 360 : -rotation / 360),
          child: Card(
            color: Colors.white,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Container(
              alignment: Alignment.center,
              width: screenSize.width * 0.9,
              height: screenSize.height / 1.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _inforWidget(state, person),
            ),
          ),
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
      elevation: 4.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        alignment: Alignment.center,
        width: screenSize.width * 0.9,
        height: screenSize.height / 1.6,
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
              flex: 1,
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
              flex: 3,
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
              RichText(
                text: TextSpan(
                    text: 'Hi, My name is\n',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: ScreenUtil().setSp(18)),
                    children: [
                      TextSpan(
                          text: '$fullName',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil().setSp(24)))
                    ]),
                textAlign: TextAlign.center,
              ),
              Table(
                defaultColumnWidth: FractionColumnWidth(0.25),
                children: [
                  TableRow(children: [
                    _personTabElementWidget(state, FontAwesomeIcons.user, 0),
                    _personTabElementWidget(state, FontAwesomeIcons.envelope, 1),
                    _personTabElementWidget(state, FontAwesomeIcons.calendar, 2),
                    _personTabElementWidget(state, FontAwesomeIcons.map, 3),
                  ]),
                  TableRow(children: [
                    _personTabElementWidget(state, FontAwesomeIcons.phoneAlt, 4),
                    _personTabElementWidget(state, FontAwesomeIcons.lock, 5),
                    SizedBox(),
                    SizedBox()
                  ])
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  _personTabElementWidget(HomeState state, IconData icon, int tabIndex) {
    return FlipCard(
      onFlip: () => BlocProvider.of<HomeBloc>(context)..add(PersonTabOnFlipEvent(tabIndex)),
      direction: FlipDirection.VERTICAL,
      front: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
        child: Icon(
          icon,
          color: Colors.black26,
          size: ScreenUtil().setHeight(40),
        ),
      ),
      back: Container(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
        child: Icon(
          icon,
          color: state is HomeSuccessState ? state.tabIndex == tabIndex ? Colors.blue : Colors.black : Colors.black,
          size: ScreenUtil().setHeight(40),
        ),
      ),
    );
  }
}
