function results = run_CN(seq, res_path, bSaveImage)
    params.padding = 1;         			   % extra area surrounding the target
    params.output_sigma_factor = 1/16;		   % spatial bandwidth (proportional to target)
    params.sigma = 0.2;         			   % gaussian kernel bandwidth
    params.lambda = 1e-2;					   % regularization (denoted "lambda" in the paper)
    params.learning_rate = 0.075;			   % learning rate for appearance model update scheme (denoted "gamma" in the paper)
    params.compression_learning_rate = 0.15;   % learning rate for the adaptive dimensionality reduction (denoted "mu" in the paper)
    params.non_compressed_features = {'gray'}; % features that are not compressed, a cell with strings (possible choices: 'gray', 'cn')
    params.compressed_features = {'cn'};       % features that are compressed, a cell with strings (possible choices: 'gray', 'cn')
    params.num_compressed_dim = 2;             % the dimensionality of the compressed features
    params.visualization = 0;
    
    seq = evalin('base', 'subS');
    target_sz = seq.init_rect(1,[4,3]);
    params.init_pos = seq.init_rect(1,[2,1]) + floor(target_sz/2);
    params.wsize = seq.init_rect(1,[4,3]);
    params.img_files = seq.s_frames;   
    params.video_path = [];
    
    [positions, fps] = color_tracker(params);
    rects = [positions(:,2) - target_sz(2)/2, positions(:,1) - target_sz(1)/2];
    rects(:,3) = target_sz(2);
    rects(:,4) = target_sz(1);
    results.type = 'rect';
    results.res = rects;

    results.fps = fps;
    disp(['fps: ' num2str(fps)])

end
