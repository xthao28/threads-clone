import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/features/domain/entities/user/user_entity.dart';
import 'package:threads_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:threads_clone/features/presentation/page/search/widget/single_card_user_widget.dart';

import '../../../../../utils/colors.dart';
import '../../../../../utils/widgets.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({super.key});

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers(user: const UserEntity());
    super.initState();    
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, userState){
            if(userState is UserLoaded){
              final filterAllUsers = _searchController.text.isNotEmpty ? userState.users.where((user) =>
                user.username!.startsWith(_searchController.text) ||
                  user.username!.toLowerCase().startsWith(_searchController.text.toLowerCase()) ||
                  user.username!.contains(_searchController.text) ||
                  user.username!.toLowerCase().contains(_searchController.text.toLowerCase())
              ).toList() :
              userState.users.take(10).toList();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titlePage('Search'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(                    
                      height: 36,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: lightGreyColor,                      
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              CupertinoIcons.search,
                              size: 16,
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search'
                              ),
                            ),
                          ),                          
                        ],
                      ),
                    ),
                  ),
                  sizeVer(25),
                  Expanded(
                    child: ListView.builder(                
                      itemCount: filterAllUsers.length,
                      itemBuilder: (context, index){
                        final user = filterAllUsers[index];
                        return SingleCardUserWidget(currentUser: user);
                      },
                    ),
                  )
                ],
              );
            }
            return Center(child: circularIndicatorThreads());
          }
        ),
      ),
    );
  }
}