import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../core/constants/image/images.dart';

class JetonTeklifSheet extends StatelessWidget {
  const JetonTeklifSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildGlow(context),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderText(context),
              const SizedBox(height: 20),
              _buildBonusSection(context),
              const SizedBox(height: 20),
              _buildUnlockText(context),
              const SizedBox(height: 20),
              _buildJetonCards(),
              const SizedBox(height: 24),
              _buildSeeAllButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlow(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      height: 120,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withOpacity(0.2), spreadRadius: 30, blurRadius: 100)],
        ),
      ),
    );
  }

  Widget _buildHeaderText(BuildContext context) {
    return Column(
      children: [
        Text(
          'jeton.limited_offer'.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          'jeton.limited_description'.tr(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildBonusSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onBackground.withOpacity(0.05), borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        children: [
          Text(
            'jeton.bonus_title'.tr(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BonusWidget(imageUrl: AppImages.instance.pro1, title: 'jeton.bonus1'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro2, title: 'jeton.bonus2'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro3, title: 'jeton.bonus3'.tr()),
              BonusWidget(imageUrl: AppImages.instance.pro4, title: 'jeton.bonus4'.tr()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockText(BuildContext context) {
    return Text('jeton.unlock_text'.tr(), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary));
  }

  Widget _buildJetonCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        JetonCard(
          bonus: '+10%',
          eski: '200',
          yeni: '330',
          fiyat: '₺99,99',
          imageUrl: AppImages.instance.coin10,
          titleImageUrl: AppImages.instance.frame10,
        ),
        JetonCard(
          bonus: '+70%',
          eski: '2.000',
          yeni: '3.375',
          fiyat: '₺799,99',
          imageUrl: AppImages.instance.coin70,
          titleImageUrl: AppImages.instance.frame70,
        ),
        JetonCard(
          bonus: '+35%',
          eski: '1.000',
          yeni: '1.350',
          fiyat: '₺399,99',
          imageUrl: AppImages.instance.coin35,
          titleImageUrl: AppImages.instance.frame35,
        ),
      ],
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minimumSize: const Size.fromHeight(50),
      ),
      onPressed: () {},
      child: Text(
        'jeton.see_all'.tr(),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BonusWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  const BonusWidget({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(image: AssetImage(AppImages.instance.ellipse), fit: BoxFit.cover),
          ),
          child: Image.asset(imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class JetonCard extends StatelessWidget {
  final String bonus;
  final String eski;
  final String yeni;
  final String fiyat;
  final String imageUrl;
  final String titleImageUrl;

  const JetonCard({
    super.key,
    required this.bonus,
    required this.eski,
    required this.yeni,
    required this.fiyat,
    required this.imageUrl,
    required this.titleImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 24.h,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        eski,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        yeni,
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Jeton',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  Divider(color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3)),
                  Column(
                    children: [
                      Text(
                        fiyat,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w900, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        'jeton.per_week'.tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              left: 7.w,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(titleImageUrl), fit: BoxFit.cover),
                ),
                child: Text(
                  bonus,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 15, color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
