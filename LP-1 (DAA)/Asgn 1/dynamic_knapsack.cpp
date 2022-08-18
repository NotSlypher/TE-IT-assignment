#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int dynamic_knapsack(int n, int c, vector<pair<int,int>> o){
    int i, w;
    vector<vector<int>> K(n + 1, vector<int>(c + 1));

    for(i = 0; i <= n; i++)
    {
        for(w = 0; w <= c; w++)
        {
            if (i == 0 || w == 0)
                K[i][w] = 0;
            else if (o[i - 1].first <= w)
                K[i][w] = max(o[i - 1].second + K[i - 1][w - o[i - 1].first],K[i - 1][w]);
            else
                K[i][w] = K[i - 1][w];
        }
    }
    return K[n][c];
}

int main(){
    int c, n;
    vector<pair<int,int>> o;
    cout << "Enter the capacity of knapsack => ";
    cin >> c;
    cout << "\nEnter the number of objects => ";
    cin >> n;
    cout << "\nEnter the weight and value of objects => \n";
    for (int i = 0; i < n; i++)
    {
        int w,v;
        cin >> w >> v;
        o.push_back(make_pair(w,v));
    }
    cout << "\nmax profit is => " << dynamic_knapsack(n,c,o) << endl;
}