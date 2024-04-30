import 'package:flutter/material.dart';
import 'package:kakelay_portfolio/presentation/widgets/buttons/nimbus_button.dart';
import 'package:kakelay_portfolio/presentation/widgets/buttons/social_button.dart';
import 'package:kakelay_portfolio/presentation/widgets/empty.dart';
import 'package:kakelay_portfolio/presentation/widgets/nimbus_vertical_divider.dart';
import 'package:kakelay_portfolio/presentation/widgets/spaces.dart';
import 'package:kakelay_portfolio/utils/functions.dart';

import 'package:responsive_builder/responsive_builder.dart';

import '../../../../../values/values.dart';
import '../../../../layout/adaptive.dart';
import '../../../../widgets/nav_item.dart';

const double logoSpaceLeftLg = 40.0;
const double logoSpaceLeftSm = 20.0;
const double logoSpaceRightLg = 70.0;
const double logoSpaceRightSm = 35.0;
const double contactButtonSpaceLeftLg = 60.0;
const double contactButtonSpaceLeftSm = 30.0;
const double contactButtonSpaceRightLg = 40.0;
const double contactButtonSpaceRightSm = 20.0;
const double contactBtnWidthLg = 150.0;
const double contactBtnWidthSm = 120.0;
const int menuSpacerRightLg = 5;
const int menuSpacerRightMd = 4;
const int menuSpacerRightSm = 3;

class NavSectionWeb extends StatefulWidget {
  final List<NavItemData> navItems;

  const NavSectionWeb({super.key, required this.navItems});

  @override
  _NavSectionWebState createState() => _NavSectionWebState();
}

class _NavSectionWebState extends State<NavSectionWeb> {
  @override
  Widget build(BuildContext context) {
    double logoSpaceLeft =
        responsiveSize(context, logoSpaceLeftSm, logoSpaceLeftLg);
    double logoSpaceRight =
        responsiveSize(context, logoSpaceRightSm, logoSpaceRightLg);
    double contactBtnSpaceLeft = responsiveSize(
      context,
      contactButtonSpaceLeftSm,
      contactButtonSpaceLeftLg,
    );
    double contactBtnSpaceRight = responsiveSize(
      context,
      contactButtonSpaceRightSm,
      contactButtonSpaceRightLg,
    );
    double contactBtnWidth = responsiveSize(
      context,
      contactBtnWidthSm,
      contactBtnWidthLg,
    );
    int menuSpacerRight = responsiveSizeInt(
      context,
      menuSpacerRightSm,
      menuSpacerRightLg,
      md: menuSpacerRightMd,
    );

    return Container(
      height: Sizes.HEIGHT_100,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          Shadows.elevationShadow,
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: logoSpaceLeft),

            ///KakElay

            Container(
              width: 80.0,
              height: 80.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/110383694?v=4')),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.redAccent,
              ),
            ),

            SizedBox(width: logoSpaceRight),
            const NimbusVerticalDivider(),
            const Spacer(flex: 1),
            ..._buildNavItems(widget.navItems),
            Spacer(flex: menuSpacerRight),
            ResponsiveBuilder(
              refinedBreakpoints: const RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth <
                    (const RefinedBreakpoints().desktopSmall + 450)) {
                  return Empty();
                } else {
                  return Row(
                    children: [
                      ..._buildSocialIcons(Data.socialData),
                      SpaceW20(),
                    ],
                  );
                }
              },
            ),
            const NimbusVerticalDivider(),
            SizedBox(width: contactBtnSpaceLeft),
            NimbusButton(
              buttonTitle: StringConst.CONTACT_ME,
              width: contactBtnWidth,
              // onPressed: () => openUrlLink(StringConst.EMAIL_URL),
              opensUrl: true,
              url: StringConst.EMAIL_URL,
            ),
            SizedBox(width: contactBtnSpaceRight),
          ],
        ),
      ),
    );
  }

  _onTapNavItem({
    required GlobalKey context,
    required String navItemName,
  }) {
    for (int index = 0; index < widget.navItems.length; index++) {
      if (navItemName == widget.navItems[index].name) {
        scrollToSection(context.currentContext!);
        setState(() {
          widget.navItems[index].isSelected = true;
        });
      } else {
        widget.navItems[index].isSelected = false;
      }
    }
  }

  List<Widget> _buildNavItems(List<NavItemData> navItems) {
    List<Widget> items = [];
    for (int index = 0; index < navItems.length; index++) {
      items.add(
        NavItem(
          title: navItems[index].name,
          isSelected: navItems[index].isSelected,
          onTap: () => _onTapNavItem(
            context: navItems[index].key,
            navItemName: navItems[index].name,
          ),
        ),
      );
      items.add(const Spacer());
    }
    return items;
  }

  List<Widget> _buildSocialIcons(List<SocialButtonData> socialItems) {
    List<Widget> items = [];
    for (int index = 0; index < socialItems.length; index++) {
      items.add(
        SocialButton(
          tag: socialItems[index].tag,
          iconData: socialItems[index].iconData,
          onPressed: () => openUrlLink(socialItems[index].url),
        ),
        // NimBusLink(
        //   url: socialItems[index].url,
        //   child: SocialButton(
        //     tag: socialItems[index].tag,
        //     iconData: socialItems[index].iconData,
        //     onPressed: (){},
        //   ),
        // ),
      );
      items.add(SpaceW16());
    }
    return items;
  }
}
