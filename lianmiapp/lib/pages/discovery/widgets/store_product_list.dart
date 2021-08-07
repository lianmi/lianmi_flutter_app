import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/widgets/load_image.dart';

class StoreProductList extends StatelessWidget {
  final List<ProductModel> productList;

  final ValueSetter<ProductModel> onTap;

  StoreProductList(this.productList, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    double itemHeight = 115.px;
    int crossAxisCount = 0;
    double childAspectRatio = 0;
    if (productList.length == 1) {
      crossAxisCount = 1;
      childAspectRatio = (375.px - 32.px) / itemHeight;
    } else if (productList.length == 2) {
      crossAxisCount = 2;
      childAspectRatio = (375.px - 32.px) / 2 / itemHeight;
    } else {
      crossAxisCount = 3;
      childAspectRatio = 1;
    }

    return SliverPadding(
        padding: EdgeInsets.all(16.px),
        sliver: SliverToBoxAdapter(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.px))),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: productList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return _productListItem(context, productList[index],
                        onTap: (ProductModel model) {
                      if (this.onTap != null) {
                        this.onTap(model);
                      }
                    });
                  },
                ))));
  }

  Widget _productListItem(BuildContext context, ProductModel model,
      {required ValueSetter<ProductModel> onTap}) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadImageWithHolder(
              model.productPic1Large ?? '',
              holderImg: ImageStandard.logo,
              width: 48.px,
              height: 48.px,
            ),
            Gaps.vGap8,
            CommonText(
              model.productName ?? '',
              fontSize: 14.px,
            )
          ],
        ),
      ),
      onTap: () {
        if (onTap != null) {
          onTap(model);
        }
      },
    );
  }
}
