import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors_discover/providers/user_state_provider.dart';
import 'package:vendors_discover/utils/custom_dialogs.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: Text("Your Favorites"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: Consumer<UserStateProvider>(
                builder: (context, favoriteVendor, widget) {
                  if (favoriteVendor.favorites.isEmpty) {
                    return const Center(child: Text("No favorites yet"));
                  }
                  return ListView.builder(
                    itemCount: favoriteVendor.favorites.length,
                    itemBuilder: (context, index) {
                      final fvendor = favoriteVendor.favorites[index];
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  fvendor['profileImg'],
                                ),
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(fvendor['name']),
                                  Text(fvendor['category']),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  UserStateProvider().removeFromFavorites(
                                    index,
                                  );
                                  CustomDialogs.showSuccessSnackBar(
                                    context,
                                    'Removed',
                                  );
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
