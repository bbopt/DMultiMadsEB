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
/*                  DTLZ5n2                */
/*----------------------------------------*/
class DTLZ5n2 : public Multi_Obj_Evaluator
{

    public:
        DTLZ5n2(const NOMAD::Parameters &p) : NOMAD::Multi_Obj_Evaluator(p) {}

        ~DTLZ5n2(void) {}

        bool eval_x(NOMAD::Eval_Point &x,
                const NOMAD::Double &h_max,
                bool &count_eval) const
        {
            // number of variables and objective functions
            int n = 2;
            int m = 2;

            // other parameters
            int k = n - m + 1;

            NOMAD::Double g = 0;
            for (int i = m - 1; i < n; ++i)
            {
                g += pow(x[i].value(), 0.1);
            }

            NOMAD::Point theta(n, 0);
            for (int i = 0; i < n; ++i)
            {
                theta[i] = (PI / 2) * (1 + 2 * g * x[i]) / (2 * (1 + g));
            }

            // objective functions
            NOMAD::Double f1 = (1 + g) * cos(x[0].value() * PI / 2);
            for (int i = 1; i < m - 1; ++i)
            {
                f1 *= cos(theta[i].value());
            }
            x.set_bb_output(0, f1);

            for (int i = 1; i < m - 1; ++i)
            {
                NOMAD::Double tmp_f = (1 + g) * cos(x[0].value() * PI / 2);
                for (int j = 2; j < m - i - 1; ++j)
                {
                    tmp_f *= cos(theta[j].value());
                }
                tmp_f *= sin(theta[m - i - 1].value());
                x.set_bb_output(i, tmp_f);
            }

            x.set_bb_output(m - 1, (1 + g) * sin(0.5 * PI * x[0].value()));

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

        NOMAD::Point lb(n, 0);
        NOMAD::Point ub(n, 1.0);

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

        //p.set_MULTI_NB_MADS_RUNS(30);

        // p.set_TMP_DIR ("/tmp");      // directory for
        // temporary files

        p.set_HISTORY_FILE("DTLZ5n2_bimads.txt");
        p.set_STATS_FILE("test_DTLZ5n2.txt", "BBE OBJ");

        // disable models
        p.set_DISABLE_MODELS();

        // disable NM search
        p.set_NM_SEARCH(false);

        // parameters validation:
        p.check();

        // custom evaluator creation:
        DTLZ5n2 ev(p);

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
