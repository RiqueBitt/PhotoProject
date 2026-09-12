#include "ui/splash_artwork.hpp"

#include <QColor>
#include <QPainter>
#include <QPaintEvent>
#include <QPixmap>

#include <algorithm>

namespace patchy::ui {

namespace {

// The artwork was designed at the About dialog's 210x270; painting happens in that
// logical space and scales uniformly so other sizes keep the same proportions.
constexpr int kLogicalWidth = 210;
constexpr int kLogicalHeight = 270;

}  // namespace

SplashArtwork::SplashArtwork(QWidget* parent) : QWidget(parent) {}

void SplashArtwork::paintEvent(QPaintEvent* event) {
  Q_UNUSED(event);

  QPainter painter(this);
  painter.setRenderHint(QPainter::Antialiasing);
  painter.setRenderHint(QPainter::SmoothPixmapTransform);

  const qreal scale = std::min(width() / qreal(kLogicalWidth), height() / qreal(kLogicalHeight));
  painter.translate((width() - kLogicalWidth * scale) / 2.0, (height() - kLogicalHeight * scale) / 2.0);
  painter.scale(scale, scale);

  // Item pedido: "com a cara do Project Club" — troca o cartão desenhado à
  // mão (um "remendo" estilizado, referência ao nome "Patchy") pelo logo
  // "PC" real do Project Club, no mesmo estilo visual usado no ícone do
  // app (fundo escuro arredondado, logo em destaque). O card em volta
  // (mesma forma/tamanho de antes) mantém a moldura consistente com o
  // resto da tela "Sobre"/tela inicial.
  const QRectF bounds = QRectF(0, 0, kLogicalWidth, kLogicalHeight).adjusted(10, 14, -10, -14);
  painter.setPen(Qt::NoPen);
  painter.setBrush(QColor(18, 18, 22));
  painter.drawRoundedRect(bounds, 28, 28);

  static const QPixmap logo(QStringLiteral(":/patchy/icons/app-logo.png"));
  if (!logo.isNull()) {
    const QRectF logo_rect = bounds.adjusted(28, 28, -28, -28);
    const QPixmap scaled_logo = logo.scaled(logo_rect.size().toSize(), Qt::KeepAspectRatio, Qt::SmoothTransformation);
    const QPointF logo_pos(logo_rect.left() + (logo_rect.width() - scaled_logo.width()) / 2.0,
                           logo_rect.top() + (logo_rect.height() - scaled_logo.height()) / 2.0);
    painter.drawPixmap(logo_pos, scaled_logo);
  }
}

}  // namespace patchy::ui
