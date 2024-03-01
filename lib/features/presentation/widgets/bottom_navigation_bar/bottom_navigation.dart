import 'package:flutter/material.dart';
import 'package:threads_clone/features/presentation/page/main_screen/main_screen.dart';

import '../../../../utils/colors.dart';
import 'tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, 
    required this.onSelectTab,
    required this.tabs,
  });
  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: 28,
      showSelectedLabels: false,
      showUnselectedLabels: false,      
      elevation: 0,      
      items: tabs
          .map(
            (e) => _buildItem(
              index: e.getIndex(),              
              tabName: e.tabName,               
            ),
          )
          .toList(),
      onTap: (index) => onSelectTab(
        index,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(
      {required int index, required String tabName}) {
    return BottomNavigationBarItem(
      icon: _tabIcon(index: index),                      
      label: tabName,        
      // activeIcon: _tabIcon(index: index),                
    );
  }

  _tabIcon({required int index}) {
    if(index == 0){
      return MainScreenState.currentIndex == index ? 
      assetImage('feed-fill.png', Colors.black) : 
      assetImage('feed.png', grey);
    }   
    else if(index == 1){
      return MainScreenState.currentIndex == index ? 
      assetImage('explore-fill.png', Colors.black) : 
      assetImage('explore.png', grey);
    } 
    else if(index == 3){
      return MainScreenState.currentIndex == index ? 
      assetImage('heart-fill.png', Colors.black) : 
      assetImage('heart.png', grey);
    }   
    else if(index == 4){
      return MainScreenState.currentIndex == index ? 
      assetImage('account-fill.png', Colors.black) : 
      assetImage('account.png', grey);
    }else{
      return const ImageIcon(
        AssetImage('assets/images/write.png'),
        color: grey,
      );
    }    
  }
}



Widget assetImage(String fileName, Color color){
  return ImageIcon(
    AssetImage(
      'assets/images/$fileName',      
    ),    
    color: color,
  );
}