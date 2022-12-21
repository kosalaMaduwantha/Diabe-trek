import 'package:diabe_trek/screens/PHYACT/create_new_routine_p2(recommended%20activities)(phy).dart';
import 'package:diabe_trek/screens/PHYACT/create_new_routine_p3(recommend%20act%20form).dart';
import 'package:diabe_trek/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:diabe_trek/utils/styles.dart';
import 'package:gap/gap.dart';


import 'Recommended_activities(phy).dart';
import 'Routines_created(phy).dart';
import 'custom_rect_tween(phy).dart';
import 'hero_dialog_route(phy).dart';

/// {@template add_todo_button}
/// Button to add a new [Todo].
///
/// Opens a [HeroDialogRoute] of [_AddTodoPopupCard].
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class AddTodoButtonRec extends StatelessWidget {
  /// {@macro add_todo_button}
  const AddTodoButtonRec({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return  _AddTodoPopupCard();
          }));
        },
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Color.fromRGBO(99,105,150,1.0),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 45,

            ),
          ),
        ),
      ),
    );
  }
}

/// Tag-value used for the add todo popup button.
const String _heroAddTodo = 'add-todo-hero';

/// {@template add_todo_popup_card}
/// Popup card to add a new [Todo]. Should be used in conjuction with
/// [HeroDialogRoute] to achieve the popup effect.
///
/// Uses a [Hero] with tag [_heroAddTodo].
/// {@endtemplate}
class _AddTodoPopupCard extends StatelessWidget {
  /// {@macro add_todo_popup_card}
  const _AddTodoPopupCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: Color.fromRGBO(99,105,150,1.0),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(20),

                    Text('change recommended activities', style: Styles.headlineStyle4.copyWith(color: Colors.white),),

                    Gap(20),

                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    Container(

                      child: Row(
                        children: [
                          FlatButton(

                            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateRoutineP03()));},
                            child: Text('Change', style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                          ),
                          FlatButton(

                            onPressed: () {},
                            child: Text('Keep', style: Styles.headlineStyle4.copyWith(color: Colors.white),),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
