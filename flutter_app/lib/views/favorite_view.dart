import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/models/model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavoriteView extends StatefulWidget {
  final List<Person> people;

  const FavoriteView({Key key, this.people}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FavoriteViewState();
}

class FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _mAppBar(context),
      body: _mBody(),
    );
  }

  Widget _mAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.black87,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "FAVORITES",
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
              '${this.widget.people.length}',
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

  _mBody() {
    return ListView.builder(
        itemCount: this.widget.people.length,
        itemBuilder: (context, index) {
          Person person = this.widget.people[index];
          print('${person.toJson()}');
          return _favoritePersonElementWidget(person);
        });
  }

  _favoritePersonElementWidget(Person person) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtil().setHeight(15),
        horizontal: ScreenUtil().setWidth(18)
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(

            vertical: ScreenUtil().setHeight(15)
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: <Widget>[
                      Container(
                        height: ScreenUtil().setHeight(100),
                        width: ScreenUtil().setHeight(100),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.black26,
                                width: ScreenUtil().setWidth(1.5)),
                            color: Colors.white),
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: ScreenUtil().setHeight(72),
                          height: ScreenUtil().setHeight(72),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage("${person.picture.large}")),
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          padding: EdgeInsets.all(2),
                          child: person.gender == "male"
                              ? Icon(FontAwesomeIcons.mars, color: Colors.blue)
                              : Icon(FontAwesomeIcons.venus, color: Colors.pink))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${person.name.getFullName()}",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenUtil().setSp(28),
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                      ),
                      Text(
                        "${person.email}",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.normal),
                      ),
                      Text(
                        "${person.phone}",
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: ScreenUtil().setSp(18),
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
