#include <iostream>
#include "nomad.hpp"
#include "math.h"
using namespace NOMAD;

const double PI = 3.141592653589793238463;

/*-----------------------------------------------------*/
/*  how to use the NOMAD library with a user function  */
/*-----------------------------------------------------*/
using namespace std;

// using namespace NOMAD; avoids putting NOMAD:: everywhere

/*----------------------------------------*/
/*                  ZDT1                */
/*----------------------------------------*/
class ZDT1 : public Multi_Obj_Evaluator
{

    public:
        ZDT1(const NOMAD::Parameters &p) : NOMAD::Multi_Obj_Evaluator(p) {}

        ~ZDT1(void) {}

        bool eval_x(NOMAD::Eval_Point &x,
                const NOMAD::Double &h_max,
                bool &count_eval) const
        {
            int n = 30;
            NOMAD::Double g = 0;
            for (int i = 1; i < n; ++i)
            {
                g += x[i];
            }
            g *= 9.0 / (n - 1);
            g += 1;

            NOMAD::Double f1 = x[0];
            NOMAD::Double h = 1 - sqrt(f1.value() / g.value());

            x.set_bb_output(0, f1);    // objective 1
            x.set_bb_output(1, g * h); // objective 2

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

        // dimensions of the black box
        int n = 30;
        int m = 2;

        p.set_DIMENSION(n); // number of variables

        vector<NOMAD::bb_output_type> bbot(m); // definition of output types
        for (int i = 0; i < m; ++i)
        {
            bbot[i] = OBJ;
        }
        p.set_BB_OUTPUT_TYPE(bbot);

        //    p.set_DISPLAY_ALL_EVAL(true);   // displays all evaluations.

        NOMAD::Point lb(n, 0);
        NOMAD::Point ub(n, 1);

        p.set_LOWER_BOUND(lb); // all var. >= 0.0
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

        //    p.set_DISPLAY_ALL_EVAL(true);   // displays all evaluations.

        // p.set_LH_SEARCH(20, -1);

        //p.set_DISPLAY_DEGREE(NOMAD::MINIMAL_DISPLAY);
        p.set_DISPLAY_STATS("obj");

        p.set_MULTI_OVERALL_BB_EVAL(20000); // the algorithm terminates after
        // 100 black-box evaluations

        // p.set_MULTI_NB_MADS_RUNS(30);

        // p.set_TMP_DIR ("/tmp");      // directory for
        // temporary files

        p.set_HISTORY_FILE("ZDT1_bimads.txt");
        p.set_STATS_FILE("test_ZDT1.txt", "BBE OBJ");

        // disable models
        p.set_DISABLE_MODELS();

        // disable NM search
        p.set_NM_SEARCH(false);

        // parameters validation:
        p.check();

        // custom evaluator creation:
        ZDT1 ev(p);

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
