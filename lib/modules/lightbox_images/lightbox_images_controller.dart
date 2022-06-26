abstract class LightBoxImagesContract {
  onOpen();
  onClose();
  onOpenImageURL(String _url);
}

class LightBoxImagesPresenter {
  LightBoxImagesContract _view;

  attach(LightBoxImagesContract view) {
    _view = view;
  }

  open() => _view.onOpen();

  openImageURL(String imageUrl) => _view.onOpenImageURL(imageUrl);

  close() => _view.onClose();
}
