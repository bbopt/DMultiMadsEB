#include <iostream>
#include "nomad.hpp"
#include "math.h"
using namespace NOMAD;
using namespace std;

/*----------------------------------------*/
/*               CL1                      */
/*----------------------------------------*/
class CL1 : public NOMAD::Multi_Obj_Evaluator
{

public:
  CL1(const NOMAD::Parameters &p) :

                                    NOMAD::Multi_Obj_Evaluator(p)
  {
  }

  ~CL1(void) {}

  bool eval_x(NOMAD::Eval_Point &x,
              const NOMAD::Double &h_max,
              bool &count_eval) const
  {
    NOMAD::Double L = 200;
    NOMAD::Double F = 10;
    NOMAD::Double E = 200000;

    NOMAD::Double f1 = 2 * x[0] + sqrt(2) * x[1] + sqrt(x[2].value()) + x[3];
    f1 *= L;

    NOMAD::Double f2 = (2 / x[0]) + 2 * sqrt(2) / x[1].value() - 2 * sqrt(2) / x[2].value() + 2 / x[3];
    f2 *= (L * F / E);

    x.set_bb_output(0, f1); // objective 1
    x.set_bb_output(1, f2); // objective 2

    count_eval = true; // count a black-box evaluation

    return true; // the evaluation succeeded
  }
};

/*------------------------------------------*/
/*            NOMAD main function           */
/*------------------------------------------*/
int main(int argc, char **argv)
{

  // display:
  NOMAD::Display out(std::cout);
  out.precision(NOMAD::DISPLAY_PRECISION_STD);

  try
  {

    // NOMAD initializations:
    NOMAD::begin(argc, argv);

    // parameters creation:
    NOMAD::Parameters p(out);

    // dimensions of the blackbox
    int n = 4;
    int m = 2;

    p.set_DIMENSION(n); // number of variables

    vector<NOMAD::bb_output_type> bbot(m); // definition of output types
    for (int i = 0; i < m; ++i)
    {
      bbot[i] = OBJ;
    }
    p.set_BB_OUTPUT_TYPE(bbot);

    // p.set_DISPLAY_ALL_EVAL(true);   // displays all evaluations.

    // parameters
    NOMAD::Double F = 10.0;
    NOMAD::Double sigma = 10.0;

    NOMAD::Point lb(n);
    lb[0] = F / sigma;
    lb[1] = sqrt(2) * F / sigma;
    lb[2] = sqrt(2) * F / sigma;
    lb[3] = F / sigma;

    NOMAD::Point ub(n, 3 * F / sigma);

    p.set_LOWER_BOUND(lb); // all var. >= lb
    p.set_UPPER_BOUND(ub); //all var <= ub

    //NOMAD::Point x0(n, 0);
    //Bimads line initialization
    for (int j = 0; j < n; ++j)
    {
      NOMAD::Point x0(n, 0);
      for (int i = 0; i < n; ++i)
      {
        x0[i] = lb[i] + j * (ub[i] - lb[i]) / (n - 1);
      }
      p.set_X0(x0);
    }
    //p.set_X0(x0); // starting poin

    //p.set_LH_SEARCH(20,-1);

    //p.set_DISPLAY_DEGREE(NOMAD::MINIMAL_DISPLAY);
    p.set_DISPLAY_STATS("obj");

    p.set_MULTI_OVERALL_BB_EVAL(20000); // the algorithm terminates after
    // 100 black-box evaluations
    
    // p.set_MULTI_NB_MADS_RUNS(30);

    //p.set_MULTI_OVERALL_BB_EVAL (100); // the algorithm terminates after
    // 100 black-box evaluations

    // p.set_TMP_DIR ("/tmp");      // directory for
    // temporary files
    
    p.set_HISTORY_FILE("CL1_bimads.txt");
    p.set_STATS_FILE("test_CL1.txt", "BBE OBJ");

    // disable models
    p.set_DISABLE_MODELS();

    // disable Nelder Mead search
    p.set_NM_SEARCH(false);

    // parameters validation:
    p.check();

    // custom evaluator creation:
    CL1 ev(p);

    // algorithm creation and execution:
    Mads mads(p, &ev);
    mads.multi_run();
  }
  catch (exception &e)
  {
    cerr << "\nNOMAD has been interrupted (" << e.what() << ")\n\n";
  }

  Slave::stop_slaves(out);
  end();

  return EXIT_SUCCESS;
}
