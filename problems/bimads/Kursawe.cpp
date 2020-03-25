#include <iostream>
#include "nomad.hpp"
#include "math.h"
using namespace NOMAD;

/*-----------------------------------------------------*/
/*  how to use the NOMAD library with a user function  */
/*-----------------------------------------------------*/
using namespace std;

// using namespace NOMAD; avoids putting NOMAD:: everywhere

/*----------------------------------------*/
/*                  Kursawe                */
/*----------------------------------------*/
class Kursawe : public Multi_Obj_Evaluator {

    public:
        Kursawe  ( const NOMAD::Parameters & p ) :
            NOMAD::Multi_Obj_Evaluator ( p ) {}

        ~Kursawe ( void ) {}

        bool eval_x ( NOMAD::Eval_Point   & x,
                const NOMAD::Double & h_max,
                bool                & count_eval   ) const
        {
            int n = 3;
            NOMAD::Double f1 = 0;
            for (int i = 0; i < (n - 1) ; ++i) {
                f1 += -10 * exp( -0.2 * sqrt( x[i].value() * x[i].value() +
                            x[i + 1].value() * x[i + 1].value() ) );
            }
            NOMAD::Double f2 = 0;
            for (int i = 0; i < n ; ++i) {
                f2 += pow(abs(x[i].value()), 0.8) + 5 * sin(x[i].value()) 
                    * sin(x[i].value()) * sin(x[i].value()) ;
            }

            x.set_bb_output  ( 0 , f1); // objective 1
            x.set_bb_output  ( 1 , f2); // objective 2

            count_eval = true; // count a black-box evaluation

            return true;       // the evaluation succeeded
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
        int n = 3;
        int m = 2;

        p.set_DIMENSION(n); // number of variables

        vector<NOMAD::bb_output_type> bbot(m); // definition of output types
        for (int i = 0; i < m; ++i)
        {
            bbot[i] = OBJ;
        }
        p.set_BB_OUTPUT_TYPE(bbot);

        //    p.set_DISPLAY_ALL_EVAL(true);   // displays all evaluations.

        NOMAD::Point lb(n, -5.0);
        NOMAD::Point ub(n, 5.0);

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

        p.set_HISTORY_FILE("Kursawe_bimads.txt");
        p.set_STATS_FILE("test_Kursawe.txt", "BBE OBJ");

        // disable models
        p.set_DISABLE_MODELS();

        // disable NM search
        p.set_NM_SEARCH(false);

        // parameters validation:
        p.check();

        // custom evaluator creation:
        Kursawe ev(p);

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
