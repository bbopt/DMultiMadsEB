#include <iostream>
#include "nomad.hpp"
#include "math.h"
using namespace NOMAD;
using namespace std;

/*-----------------------------------------------------*/
/*  how to use the NOMAD library with a user function  */
/*-----------------------------------------------------*/

// using namespace NOMAD; avoids putting NOMAD:: everywhere

/*----------------------------------------*/
/*               Deb41                    */
/*----------------------------------------*/
class Deb41 : public Multi_Obj_Evaluator
{
public:
  Deb41(const NOMAD::Parameters &p) : Multi_Obj_Evaluator(p) {}

  ~Deb41(void) {}

  bool eval_x(NOMAD::Eval_Point &x,
              const NOMAD::Double &h_max,
              bool &count_eval) const
  {
    NOMAD::Double f1 = x[0];
    NOMAD::Double f2 = 2 - NOMAD::Double(exp(-((x[1].value() - 0.2) / 0.004) * ((x[1].value() - 0.2) / 0.004)));
    f2 -= 0.8 * exp(-((x[1].value() - 0.6) / 0.4) * ((x[1].value() - 0.6) / 0.4));
    f2 /= f1;

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
    int n = 2;
    int m = 2;

    p.set_DIMENSION(n); // number of variables

    vector<NOMAD::bb_output_type> bbot(m); // definition of output types
    for (int i = 0; i < m; ++i)
    {
      bbot[i] = OBJ;
    }
    p.set_BB_OUTPUT_TYPE(bbot);

    //    p.set_DISPLAY_ALL_EVAL(true);   // displays all evaluations.

    NOMAD::Point lb(n, 0.0);
    lb[0] = 0.1;
    NOMAD::Point ub(n, 1.0);

    p.set_LOWER_BOUND(lb); // all var. >= 0.1
    p.set_UPPER_BOUND(ub); //all var <= 1

    for (int j = 0; j < n; ++j)
    {
      NOMAD::Point x0(n, 0);
      for (int i = 0; i < n; ++i)
      {
        x0[i] = lb[i] + j * (ub[i] - lb[i]) / (n - 1);
      }
      p.set_X0(x0);
    }
    //p.set_X0(x0); // starting point

    //p.set_LH_SEARCH(20, -1);

    //p.set_DISPLAY_DEGREE(NOMAD::MINIMAL_DISPLAY);
    p.set_DISPLAY_STATS("obj");

    p.set_MULTI_OVERALL_BB_EVAL(20000); // the algorithm terminates after
    // 100 black-box evaluations
    
    //p.set_MULTI_NB_MADS_RUNS(30);

    // p.set_TMP_DIR ("/tmp");      // directory for
    // temporary files

    p.set_HISTORY_FILE("Deb41_bimads.txt");
    p.set_STATS_FILE("test_Deb41.txt", "BBE OBJ");
    
    // disable models
    p.set_DISABLE_MODELS();

    // disable Nelder Mead
    p.set_NM_SEARCH(false);

    // parameters validation:
    p.check();

    // custom evaluator creation:
    Deb41 ev(p);

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
