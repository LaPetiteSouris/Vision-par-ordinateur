function P=get_P_from_H(H,K);

% On d e t e rm in e [R| t ] a p a r t i r de H
Pt = K\H ;
Pk = zeros( 3 , 4 ) ;
Pk ( : , 1 ) = Pt ( : , 1 ) ;
Pk ( : , 2 ) = Pt ( : , 2 ) ;
Pk ( : , 4 ) = Pt ( : , 3 ) ;
Pk ( : , 3 ) = cross( Pk ( : , 1 ) , Pk ( : , 2 ) ) ;
% N o rm a l i s a t i o n de in v (K) ∗P
% (H connue a un f a c t e u r m u l t i p l i c a t i f lambda p r e s )
lamda=nthroot(det(Pk(:,1:3)),4);
Pk ( : , 1 : 2 )=Pk ( : , 1 : 2 )./lamda;
Pk ( : , 3 )=Pk ( : , 3 )./( lamda * lamda ) ;
Pk ( : , 4 )=Pk ( : , 4 )./lamda;
% Retour a P
P = K* Pk ;