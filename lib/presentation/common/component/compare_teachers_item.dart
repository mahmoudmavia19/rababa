import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/presentation/resources/assets_manager.dart';
import 'package:rababa/presentation/resources/color_manager.dart';
import 'package:rababa/presentation/screens/student/pay/view/student_pay_confirm_screen.dart';

class CompareTeachersItem extends StatelessWidget {
    CompareTeachersItem({Key? key ,required this.user}) : super(key: key);
  UserModel user;
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: AppColor.cardColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, right: 10.0 , left: 20.0 , bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius:31.71,
              backgroundColor: Colors.white,
              backgroundImage:user.imgUrl==null?  AssetImage(AppIcons.defaultImg,) as ImageProvider: NetworkImage(user.imgUrl!),
            ),
            const SizedBox(width: 10.0,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name??'',style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),),
                const SizedBox(height:10.0,),
                Text(user.country??'',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),) ,
                const SizedBox(height:5.0,),
                RatingBar(
                  initialRating: user.rate??0.0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize:18.0 ,
                  ratingWidget: RatingWidget(
                    full: const Icon(Icons.star,color: AppColor.starColor,),
                    half: const Icon(Icons.star_half_outlined,color: AppColor.starColor,),
                    empty: const Icon(Icons.star,color:Colors.grey,),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(height:5.0,),
                Text('سعر الساعة ${user.price??0.0}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),) ,
                const SizedBox(height:10.0,),
                Text(user.certificate??'',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),)
              ],
            ),
            const Spacer(),
            Column(
              children: [
                /*if(user.isAccepted??false)
                if(!(user.isBlocked??false))*/
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>StudentPayConfirmScreen(teacher: user) ,)); 
                  },
                    child: const Icon(Icons.date_range, color: Colors.white,size: 22.0,)),
                const SizedBox(height: 20.0,),
                Text((user.rate??0.0).toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
