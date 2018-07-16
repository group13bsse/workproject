def create_fast_rcnn_model(features, roi_proposals, label_targets, bbox_targets, bbox_inside_weights, cfg):
  # Load the pre-trained classification net and clone layers
  base_model = load_model(cfg['BASE_MODEL_PATH'])
  conv_layers = clone_conv_layers(base_model, cfg)
  fc_layers = clone_model(base_model, [cfg["MODEL"].POOL_NODE_NAME], [cfg["MODEL"].LAST_HIDDEN_NODE_NAME], clone_method=CloneMethod.clone)
  
  # Normalization and conv layers
  feat_norm = features - Constant([[[v]] for v in cfg["MODEL"].IMG_PAD_COLOR])
  conv_out = conv_layers(feat_norm)
  
  # Fast RCNN and losses
  cls_score, bbox_pred = create_fast_rcnn_predictor(conv_out, roi_proposals, fc_layers, cfg)
  detection_losses = create_detection_losses(...)
  pred_error = classification_error(cls_score, label_targets, axis=1)
  
  return detection_losses, pred_error
  
  def create_fast_rcnn_predictor(conv_out, rois, fc_layers, cfg):
    # RCNN
    roi_out = roipooling(conv_out, rois, cntk.MAX_POOLING, (6, 6), spatial_scale=1/16.0)
  fc_out = fc_layers(roi_out)
  
  # prediction head
  cls_score = plus(times(fc_out, W_pred), b_pred, name='cls_score')
  
  # regression head
  bbox_pred = plus(times(fc_out, W_regr), b_regr, name='bbox_regr')
  
  return cls_score, bbox_pred
  