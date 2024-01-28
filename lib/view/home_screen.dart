import 'package:flutter/material.dart';
import 'package:mvvm_provider_example/data/response/status.dart';
import 'package:mvvm_provider_example/model/movie_list_model.dart';
import 'package:mvvm_provider_example/provider/home_provider.dart';
import 'package:mvvm_provider_example/provider/token_provider.dart';
import 'package:mvvm_provider_example/utils/routes/routes_name.dart';
import 'package:mvvm_provider_example/utils/utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeProvider homeProvider = HomeProvider();

  @override
  void initState() {
    homeProvider.fetchMovieList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
              onPressed: (){
                userProvider.removeToken().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeProvider>(
        create: (BuildContext context) => homeProvider,
        child: Consumer<HomeProvider>(builder: (context, value, child) {
          switch (value.movieApiResponse.status) {
            case Status.LOADING:
              return CircularProgressIndicator();
            case Status.ERROR:
              return Text(value.movieApiResponse.message.toString());
            case Status.COMPLETED:
              return _getMoviesListView(value.movieApiResponse.data!.movies!);
            default:
          }
          return Container();
        })
      )
    );
  }

  Widget _getMoviesListView(List<Movies> moviesList) {
    return ListView.builder(
        itemCount: moviesList.length,
        itemBuilder: (context, position) {
          return _getMovieListItem(moviesList[position]);
        });
  }

  Widget _getMovieListItem(Movies item) {
    return Card(
      child:   ListTile(
        leading: ClipRRect(
          child: Image.network(
            item.posterurl.toString(),
            errorBuilder: (context, error, stackTrace) {
              return  const Icon(Icons.error_outline);
            },
            fit: BoxFit.fill,
            width: 40,
            height: 40,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        title:  Text(item.title.toString()),
        subtitle: Text(item.year.toString()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Utils.setAverageRating(item.ratings!).toString()),
            SizedBox(width: 12,),
            Icon(Icons.star),
          ],
        ),
        onTap: () {
          _sendDataToMovieDetailScreen(context, item);
        },
      ),
      elevation: 1,
    );
  }

  void _sendDataToMovieDetailScreen(BuildContext context, Movies item) {
    //Navigator.pushNamed(context, MovieDetailsScreen.id,arguments: item);
  }
}
