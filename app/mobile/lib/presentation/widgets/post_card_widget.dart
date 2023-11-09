import 'package:flutter/material.dart';
import 'package:mobile/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;
  
  const PostCard({
    super.key, required this.post,
  });


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child:   SizedBox(
        height: 130,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Row(
                children: [
                  const Icon(Icons.account_circle),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(post.username!, style: const TextStyle(fontSize: 13)),
                    ),
                  ),
                ],
              ),
              const Center(child: SizedBox()),
              Align(
                alignment: Alignment.topLeft,
                child: Text(post.content, style: const TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,maxLines: 3),
              ),
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up_alt_rounded),
                      const SizedBox(width: 10,),
                      Text(post.likes.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.thumb_down_alt_rounded),
                      const SizedBox(width: 10,),
                      Text(post.dislikes.toString()),
                    ],
                  ), 
                  Row(
                    children: [
                      const Icon(Icons.comment),
                      const SizedBox(width: 10,),
                      Text(post.comments.toString()),
                    ],
                  ),
                ],
              )
            ]
          ),
        ) ,
      ),
    );
  }
}