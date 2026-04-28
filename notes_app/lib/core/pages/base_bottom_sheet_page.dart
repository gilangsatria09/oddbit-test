import 'package:flutter/material.dart';
import 'package:notes_app/shared_ui/theme/app_text_style.dart';

class BaseBottomSheetConfig {
  final bool useSafeArea;
  final Widget? customAction;
  final Function()? onDismissed;
  final bool showCloseIcon;
  final EdgeInsets? contentPadding;
  final String title;
  final bool isScrollControlled;
  final bool enableDrag;

  const BaseBottomSheetConfig({
    this.useSafeArea = true,
    this.customAction,
    this.onDismissed,
    this.showCloseIcon = true,
    this.contentPadding,
    this.title = '',
    this.isScrollControlled = true,
    this.enableDrag = true,
  });

  BaseBottomSheetConfig copyWith({
    bool? useSafeArea,
    Widget? customAction,
    Function()? onDismissed,
    bool? showCloseIcon,
    EdgeInsets? contentPadding,
    String? title,
  }) {
    return BaseBottomSheetConfig(
      useSafeArea: useSafeArea ?? this.useSafeArea,
      customAction: customAction ?? this.customAction,
      onDismissed: onDismissed ?? this.onDismissed,
      showCloseIcon: showCloseIcon ?? this.showCloseIcon,
      contentPadding: contentPadding ?? this.contentPadding,
      title: title ?? this.title,
    );
  }
}

abstract class BaseBottomSheetEntity {
  final BaseBottomSheetConfig config;

  BaseBottomSheetEntity({required this.config});

  Widget buildContent();
}

class DefaultBaseBottomSheetEntity extends BaseBottomSheetEntity {
  final Widget child;

  DefaultBaseBottomSheetEntity({
    required this.child,
    super.config = const BaseBottomSheetConfig(),
  });

  @override
  Widget buildContent() {
    return Padding(
      padding: config.contentPadding != null
          ? EdgeInsets.only(
              top: config.title.isEmpty ? 24 : 16,
              bottom: config.contentPadding!.bottom,
              left: config.contentPadding!.left,
              right: config.contentPadding!.right,
            )
          : EdgeInsets.only(
              top: config.title.isEmpty ? 24 : 16,
              bottom: 16,
              left: 16,
              right: 16,
            ),
      child: child,
    );
  }
}

class AutoScrollBaseBottomSheetEntity extends BaseBottomSheetEntity {
  final Widget child;
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final double maxHeightFactor;

  AutoScrollBaseBottomSheetEntity({
    required this.child,
    this.controller,
    this.physics,
    this.maxHeightFactor = 1.0,
    super.config = const BaseBottomSheetConfig(),
  });

  EdgeInsets get _padding => config.contentPadding != null
      ? EdgeInsets.only(
          top: config.title.isEmpty ? 24 : 16,
          bottom: config.contentPadding!.bottom,
          left: config.contentPadding!.left,
          right: config.contentPadding!.right,
        )
      : EdgeInsets.only(
          top: config.title.isEmpty ? 24 : 16,
          bottom: 16,
          left: 16,
          right: 16,
        );

  @override
  Widget buildContent() {
    return Builder(
      builder: (context) {
        final maxHeight = MediaQuery.of(context).size.height * maxHeightFactor;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: Scrollbar(
            child: SingleChildScrollView(
              controller: controller,
              physics: physics,
              padding: _padding,
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class BaseBottomSheetPage<T> extends Page<T> {
  final BaseBottomSheetEntity entity;

  const BaseBottomSheetPage({
    required DefaultBaseBottomSheetEntity this.entity,
  });

  const BaseBottomSheetPage.autoScroll({
    required AutoScrollBaseBottomSheetEntity this.entity,
  });

  @override
  Route<T> createRoute(BuildContext context) => ModalBottomSheetRoute<T>(
    settings: this,
    isScrollControlled: entity.config.isScrollControlled,
    showDragHandle: true,
    useSafeArea: entity.config.useSafeArea,
    enableDrag: entity.config.enableDrag,
    builder: (context) {
      return PopScope(
        canPop: canPop,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (entity.config.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    entity.config.title,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.headings.h6.bold.textStyle,
                  ),
                ),
              Flexible(child: SafeArea(child: entity.buildContent())),
            ],
          ),
        ),
      );
    },
  );
}
