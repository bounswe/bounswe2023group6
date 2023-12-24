import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/services/search_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/lfg_card_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';

enum SearchContext {
  all,
  posts,
  games,
  lfgs,
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  SearchService searchService = SearchService();

  TextEditingController controller = TextEditingController();

  SearchContext currentSearchContext = SearchContext.all;
  Map<SearchContext, List<dynamic>> searchResults = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Search'),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          buildSearchBar(),
          const SizedBox(height: 10),
          buildSearchContextDropdown(),
          const SizedBox(height: 10),
          buildSearchResults(),
        ],
      )),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.subtitle2,
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          suffixIcon: IconButton(
            onPressed: () async {
              String query = controller.text;
              if (query.isNotEmpty) {
                await searchForQuery(query);
              }
            },
            icon: const Icon(Icons.send),
          ),
        ),
      ),
    );
  }

  Future<void> searchForQuery(String query) async {
    if (currentSearchContext == SearchContext.all) {
      Map<String, List<dynamic>> results = await searchService.searchAll(query);
      searchResults = {
        SearchContext.posts: results['posts']!,
        SearchContext.games: results['games']!,
        SearchContext.lfgs: results['lfgs']!,
      };
    } else if (currentSearchContext == SearchContext.posts) {
      List<Post> results = await searchService.searchPosts(query);
      searchResults = {
        SearchContext.posts: results,
      };
    } else if (currentSearchContext == SearchContext.games) {
      List<Game> results = await searchService.searchGames(query);
      searchResults = {
        SearchContext.games: results,
      };
    } else if (currentSearchContext == SearchContext.lfgs) {
      List<LFG> results = await searchService.searchLFGs(query);
      searchResults = {
        SearchContext.lfgs: results,
      };
    }
    setState(() {});
  }

  Widget buildSearchContextDropdown() {
    return DropdownButton<SearchContext>(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      value: currentSearchContext,
      onChanged: (SearchContext? newValue) {
        if (newValue != null) {
          setState(() {
            currentSearchContext = newValue;
          });
        }
      },
      items: SearchContext.values
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e.name.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          )
          .toList(),
    );
  }

  Widget buildSearchResults() {
    if (currentSearchContext == SearchContext.all) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            buildSearchResultsForPosts(),
            const SizedBox(height: 10),
            buildSearchResultsForGames(),
            const SizedBox(height: 10),
            buildSearchResultsForLfgs(),
          ],
        ),
      );
    } else if (currentSearchContext == SearchContext.posts) {
      return buildSearchResultsForPosts();
    } else if (currentSearchContext == SearchContext.games) {
      return buildSearchResultsForGames();
    } else if (currentSearchContext == SearchContext.lfgs) {
      return buildSearchResultsForLfgs();
    }
    return Container();
  }

  Widget buildSearchResultsForPosts() {
    if (searchResults.containsKey(SearchContext.posts)) {
      List<dynamic> posts = searchResults[SearchContext.posts]!;
      Widget searchResultForPost;
      if (posts.isEmpty) {
        searchResultForPost = const Center(
          child: Text('No results found'),
        );
      }
      else {
        searchResultForPost = ListView.builder(
          shrinkWrap: true,
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            Post post = posts[index];
            return PostCard(post: post);
          },
        );
      }
      return buildSearchResultsWithWidget(SearchContext.posts, searchResultForPost);
    } else {
      return Container();
    }
  }

  Widget buildSearchResultsForGames() {
    if (searchResults.containsKey(SearchContext.games)) {
      List<dynamic> games = searchResults[SearchContext.games]!;
      Widget searchResultForGame;
      if (games.isEmpty) {
        searchResultForGame = const Center(
          child: Text('No results found'),
        );
      } else {
        searchResultForGame = ListView.builder(
          shrinkWrap: true,
          itemCount: games.length,
          itemBuilder: (BuildContext context, int index) {
            Game game = games[index];
            return GameCard(game: game);
          },
        );
      }
      return buildSearchResultsWithWidget(SearchContext.games, searchResultForGame); 
    } else {
      return Container();
    }
  }

  Widget buildSearchResultsForLfgs() {
    if (searchResults.containsKey(SearchContext.lfgs)) {
      List<dynamic> lfgs = searchResults[SearchContext.lfgs]!;
      Widget searchResultForLfg;
      if (lfgs.isEmpty) {
        searchResultForLfg = const Center(
          child: Text('No results found'),
        );
      } else {
        searchResultForLfg = ListView.builder(
          shrinkWrap: true,
          itemCount: lfgs.length,
          itemBuilder: (BuildContext context, int index) {
            LFG lfg = lfgs[index];
            return LFGCard(lfg: lfg);
          },
        );
      }
      return buildSearchResultsWithWidget(SearchContext.lfgs, searchResultForLfg);
    } else {
      return Container();
    }
  }
  
  Widget buildSearchResultsWithWidget(SearchContext searchContext, Widget searchResultWidget) {
    return Column(
      children: [
        Text(searchContext.name.toUpperCase(), style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 5),
        searchResultWidget,
      ],
    );
  }
}
