g=9.81;
L=0.5;

A=[0 1 0 0;
   0 0 0 0;
   0 0 0 1;
   0 0 g/L 0];
B=[0;1;0;-1/L];
C=[0 0 1 0];
Q=[40 0 0 0;
   0 4 0 0;
   0 0 4 0;
   0 0 0 50];
R=30;
rank(ctrb(A,B))
K=lqr(A,B,Q,R);
%validation linéaire
eig(A - B*K)
sys_cl=ss(A-B*K, zeros(4,1), eye(4), 0);
initial(sys_cl, [0;0;0.1;0])